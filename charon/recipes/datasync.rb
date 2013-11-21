#
# Author:: Steven Craig <support@smashrun.com>
# Cookbook Name:: charon
# Recipe:: datasync
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

log("begin datasync.rb for #{node[:datasync][:servicename]}") { level :debug }
log("running datasync.rb for #{node[:datasync][:servicename]}") { level :info }

["#{node[:datasync][:tempdir]}"].each do |dir|
  log("create #{dir} directory if necessary") { level :debug }
  directory "#{dir}" do
    action :create
    not_if { File.exists?("#{dir}") }
    recursive true
  end
end

log("download #{node[:datasync][:installer]} installer from web if necessary") { level :debug }
remote_file "#{node[:datasync][:installer]}" do
  action :create
  not_if { File.exists?("#{node[:datasync][:tempdir]}\\#{node[:datasync][:installer]}") }
  backup false
  source "#{node[:datasync][:url]}"
  path "#{node[:datasync][:tempdir]}\\#{node[:datasync][:installer]}"
end

#case node[:kernel][:machine]
#  when "i386"
#  log("install #{node[:datasync][:servicename]} if necessary") { level :debug }
#  execute "#{node[:datasync][:installer]}" do
#    action :run
#    timeout 180
#    command %Q(msiexec /i #{node[:datasync][:tempdir]}\\#{node[:datasync][:installer]} /quiet /qn /norestart)
#    notifies :enable, "service[#{node[:datasync][:servicename]}]"
#  end

#  when "x86_64"
#  log("install #{node[:datasync][:servicename]} if necessary") { level :debug }
#  execute "#{node[:datasync][:installer]}" do
#    action :run
#    timeout 180
#    command %Q(msiexec /i #{node[:datasync][:tempdir]}\\#{node[:datasync][:installer]} /quiet /qn /norestart)
#    notifies :enable, "service[#{node[:datasync][:servicename]}]"
#  end
#end

log("service #{node[:datasync][:servicename]} registration if necessary") { level :debug }
service "#{node[:datasync][:servicename]}" do
  action :nothing
  supports :restart => true, :stop => true, :start => true, :enable => true, :disable => true
end


log("end datasync") { level :info }
