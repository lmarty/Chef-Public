#
# Author:: Steven Craig <support@smashrun.com>
# Cookbook Name:: windows
# Recipe:: winstaller45
#
# Copyright 2010, Smashrun, Inc.
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

log("begin winstaller45.rb") { level :debug }
log("running winstaller45.rb") { level :info }

["#{node['winstaller']['tempdir']}"].each do |dir|
  log("create #{dir} directory if necessary") { level :debug }
  directory dir do
    action :create
    not_if { File.exists?(dir) }
    recursive true
  end
end

log("download #{node['winstaller']['servicename']} installer from web if necessary") { level :debug }
remote_file "#{node['winstaller']['installer']}" do
  action :create
  not_if { File.exists?("#{node['winstaller']['tempdir']}\\#{node['winstaller']['installer']}") }
  backup false
  source node['winstaller']['url']
  path "#{node['winstaller']['tempdir']}\\#{node['winstaller']['installer']}"
end

powershell "CheckWinstallerVersion" do
  code <<-EOH
    $version = (Get-Command '#{node['kernel']['os_info']['system_directory']}/MSI.dll').FileVersionInfo.FileVersion
    $stream = [System.IO.StreamWriter] "#{node['kernel']['os_info']['system_directory']}/winstaller_version.txt"
    $stream.WriteLine("$version")
    $stream.close()
  EOH
end

# if I were better this wouldn't be a dirty hack
winstaller = nil
ruby_block "slurp the winstaller version from the powershell-generated file" do
  block {
    fn = "#{node['kernel']['os_info']['system_directory']}\\winstaller_version.txt"
    fh = File.new(fn, "r")
    winstaller = fh.read
  }
end

case "#{node['kernel']['os_info']['version']}"

  when "6.1.7601"
    log("not installing #{node['winstaller']['installer']}; Windows 2008 R2 x86_64 ships with winstaller v5") { level :debug }

  when "5.2.3790"
  service "#{node['winstaller']['servicename']}" do
    action :stop
    not_if { winstaller =~ /^4.*/ }
  end

  log("install #{node['winstaller']['servicename']} if necessary") { level :debug }
  execute "#{node['winstaller']['installer']}" do
    action :run
    not_if { winstaller =~ /^4.*/ }
    timeout 60
    command %Q(#{node['winstaller']['tempdir']}\\#{node['winstaller']['installer']} /quiet /norestart)
    notifies :enable, "service[#{node['winstaller']['servicename']}]"
    # WTF? is 3010 the return for "install success, now reboot" ?
    returns [0,3010]
  end

  when "6.0.6002"
  service "#{node['winstaller']['servicename']}" do
    action :stop
    not_if { winstaller =~ ( /^4\.5\.6.*|^5.*/ ) }
  end

  log("install #{node['winstaller']['servicename']} if necessary") { level :debug }
  execute "#{node['winstaller']['installer']}" do
    action :run
    not_if { winstaller =~ ( /^4\.5\.6.*|^5.*/ ) }
    timeout 60
    command %Q(#{node['kernel']['os_info']['system_directory']}\\Wusa.exe #{node['winstaller']['tempdir']}\\#{node['winstaller']['installer']} /quiet /norestart)
    notifies :enable, "service[#{node['winstaller']['servicename']}]"
  end
end


log("end winstaller45.rb") { level :info }
