#
# Cookbook Name:: kronos
# Recipe:: schedule
#
# Copyright 2013, Smashrun, Inc.
# Author:: Steven Craig <support@smashrun.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# on windows 2008, if the template does not change, chef does not reload the task
# this is nice for efficiency; however, it means that if someone deletes the task locally,
# the node[:schedule][:workingdir] folder will need to be deleted before chef will re-create them
# on balance, I like this behaviour
#
# Task Scheduler Schema
# http://msdn.microsoft.com/en-us/library/windows/desktop/aa383609(v=vs.85).aspx

log("begin schedule") { level :debug }
log("running schedule") { level :info }

# ensure necessary dirs are setup and available
["#{node[:schedule][:tempdir]}", "#{node[:schedule][:workingdir]}"].each do |dir|
  # log("create #{dir} directory if necessary") { level :debug }
  directory "#{dir}" do
    action :create
    not_if { File.exists?("#{dir}") }
    recursive true
  end
end

# this is a hack
# ensure simple batch file for file deletion is on the server
log("create delete.bat if necessary") { level :debug }
template "#{node[:schedule][:tempdir]}\\delete.bat" do
  source "delete.bat.erb"
  variables({
            :author_name => "#{node[:schedule][:author_name]}",
            :author_email => "#{node[:schedule][:author_email]}"
  })
  backup false
end

# this is a hack
# ensure simple batch file for defrag analysis is on the server
# should be moved to the nagios cookbook
log("create defragwrap.bat if necessary") { level :debug }
template "#{node[:schedule][:tempdir]}\\defragwrap.bat" do
  source "defragwrap.bat.erb"
  variables({
            :author_name => "#{node[:schedule][:author_name]}",
            :author_email => "#{node[:schedule][:author_email]}",
            :sysdir => "#{node[:kernel][:os_info][:system_directory]}"
  })
  backup false
end

log("Begin registry search for current task list") {level :debug}
# tasks are stored inside two places inside the registry
# find the GUID references by scanning for kronos-* here:
# HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree
regbase = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache'
current_task = []
task_hash = {}

#
# uses new chef client 11 ONLY platform method "registry_get_subkeys" to search for the task keys
# otherwise the 32bit/64bit windows registry monster bites hard
# because on windows 2008 R2 x86_64, task scheduler stores the task keys
# inside the 32-bit registry section (NOT inside the 64bit section!)
# http://docs.opscode.com/dsl_recipe_method_registry_get_subkeys.html
#
# once the keys are found, the value is populated via the new "registry_get_values" method
# http://docs.opscode.com/dsl_recipe_method_registry_get_values.html

subkey_array = registry_get_subkeys("#{regbase}\\Tree", :machine)
subkey_array.each do |k|
  if k =~ /^kronos-/
    #log("found task name #{k}") {level :debug}
    kGUID = registry_get_values("#{regbase}\\Tree\\#{k}", :machine)
    task_hash = {:id => "#{kGUID[0][:data]}", :name => "#{k}"}
    #log("created task hash entry with data #{task_hash.inspect}") {level :debug}
    current_task.push(task_hash)
  end
end
log("End registry search for current task list") {level :debug}
log("Found #{current_task.length.to_s} kronos-managed tasks currently scheduled on #{node[:fqdn].downcase}") {level :info}

# organize tasks
log("Begin search for new or updated tasks to be scheduled") { level :debug }

# running_task holds the comma-separated list of tasks that run on the host
# task_info holds location and file information specific to the individual task
running_task = []
task_info = []

search(:running_task, "id:#{node[:hostname]}") do |host|
  running_task << host["task"].split(",")
  running_task.flatten!
  running_task.each do |taskname|
    search(:task_info, "id:#{taskname}") do |task|
      info = { "id" => task["id"],
        "taskname" => task["id"],
        "taskrun" => task["taskrun"],
        "taskcommand" => task["taskcommand"],
        "taskargument" => task["taskargument"],
        "schedule" => task["schedule"],
        "modifier" => task["modifier"],
        "starttime" => task["starttime"]    
      }
      task_info << info
    end
  end
  log("End search for new or updated tasks to be scheduled") { level :debug }
  log("Found #{running_task.length.to_s} tasks inside authoritative running_task data bag") {level :info}

  log("Begin deprecated Task removal, if necessary") {level :debug}
  # first, build the "remove" list of tasks we know must be removed this run
  # (because they no longer exist inside the authoritative chef data bag)
  remove = current_task.collect {|x| "#{x[:name].gsub(/^kronos-/,'')}"} - running_task
  unless remove.length == 0
    log("Found #{remove.length} currently scheduled, kronos-managed tasks to be removed this run") {level :info}
  end

  # tasks inside the "remove" array need to be unregistered via task scheduler
  remove.each do |d|
    execute "delete-task-registration-#{d}" do
      cwd "#{node[:schedule][:workingdir]}"
      command %Q(#{node[:kernel][:os_info][:system_directory]}\\schtasks.exe /delete /tn kronos-#{d} /F)
      action :run
      timeout 60
      ignore_failure true
    end
  end

  # next, find any orphaned task xml files that might be "left-over" inside the task directory
  # this list could (and should, in most cases) overlap with the "remove" list
  # but if there is an unclean run, or - more likely - if a person mucked about
  # with the registry, or the chef cache, or the task scheduler wizard, this will clean that up, too
  orphan = []
  begin
    if node[:schedule][:workingdir]
      Dir.chdir(node[:schedule][:workingdir])
      file = Dir["*"].reject{|o| File.directory?(o)}
      t = file.collect {|x| x.gsub(/\.xml$/,'')}
      #running_task.map!{|x| x + ".xml"}
      orphan = t - running_task
    else
      puts "node[:schedule][:workingdir] is required"
    end
  rescue Exception => e
    Chef::Log.warn("Error in cookbook kronos::schedule_2008 #{e}")
    Chef::Log.warn("This is expected behaviour on the initial run #{e}")
  end

  unless orphan.length == 0
    log("Found #{orphan.length} orphaned, kronos-managed xml task files to be removed this run") {level :info}
  end

  # last, add the remove and orphan lists together and unique them
  # so that the contents can be deleted from the node
  # known tasks for removal will need their xml files deleted
  # unknown xml files could also potentially accumulate and could require removal as well
  delete = remove + orphan
  delete.uniq!
  unless delete.length == 0
    log("Deleting #{delete.length} kronos-managed xml task files inside #{node[:schedule][:workingdir]}") {level :info}
  end
  delete.each do |d|
    execute "delete-task-file-#{d}.xml" do
      cwd "#{node[:schedule][:workingdir]}"
      command %Q(del /F /S /Q "#{node[:schedule][:workingdir]}\\#{d}.xml")
      action :run
      timeout 60
    end
  end

  log("End deprecated Task removal") {level :debug}

  # now create and update individual xml files, one per task
  task_info.each do |task|

    # schedule each task on notification from template
    execute "schedule-#{task["id"]}.xml" do
      cwd "#{node[:schedule][:workingdir]}"
      command %Q(#{node[:kernel][:os_info][:system_directory]}\\schtasks.exe /create /tn kronos-#{task["id"]} /xml #{node[:schedule][:workingdir]}\\#{task["id"]}.xml /F)
      action :nothing
      timeout 60
    end
  
    # chef version branches 0.10.z and 10.y.z and 11.y.z handle templates differently
    # unsure exactly what has changed but performance absolutely declined in new branch
    time = Time.new
    windate = time.strftime("%Y-%m-%d")
    wintime = time.strftime("%H:%M:%S")

    templated = nil
    begin
      templated = resources(:template => "#{node[:schedule][:basexml_template]}")
    rescue Chef::Exceptions::ResourceNotFound
      templated = template "#{node[:schedule][:workingdir]}\\#{task["id"]}.xml" do
        source "#{node[:schedule][:basexml_template]}"
        backup false
        variables({
          :task_info => task,
          :windate => windate,
          :wintime => wintime,
          :author_name => "#{node[:schedule][:author_name]}",
          :author_email => "#{node[:schedule][:author_email]}",
          :basexml => "#{node[:schedule][:basexml]}",
          :basexml_template => "#{node[:schedule][:basexml_template]}",
          :baselog => "#{node[:schedule][:baselog]}",
          :basewiki => "#{node[:schedule][:basewiki]}",
          :system_dir => "#{node[:kernel][:os_info][:system_directory]}",
          :working_dir => "#{node[:schedule][:workingdir]}"
        })
        notifies :run, resources(:execute => "schedule-#{task["id"]}.xml"), :immediately
      end
    end
  end

  # on windows 2008, if the template does not change, chef does not reload the task
  # this is nice for efficiency; however, it means that if someone deletes the task locally,
  # the node[:schedule][:workingdir] folder would need to be deleted before chef would re-create them
  # the "double-check" ensures these are re-registered each run
  double_check = running_task - current_task.collect {|x| "#{x[:name].gsub(/^kronos-/,'')}"}
  double_check.each do |t|
    execute "double-check-schedule-#{t}.xml" do
      cwd "#{node[:schedule][:workingdir]}"
      command %Q(#{node[:kernel][:os_info][:system_directory]}\\schtasks.exe /create /tn kronos-#{t} /xml #{node[:schedule][:workingdir]}\\#{t}.xml /F)
      action :run
      timeout 60
    end
  end

end # search running_task

log("end schedule") { level :info }
