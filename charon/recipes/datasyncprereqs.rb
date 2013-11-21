#
# Author:: Steven Craig <support@smashrun.com>
# Cookbook Name:: charon
# Recipe:: datasyncprereqs
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

log("begin datasyncprereqs.rb for #{node[:datasyncprereqs][:servicename]}") { level :debug }
log("running datasyncprereqs.rb for #{node[:datasyncprereqs][:servicename]}") { level :info }

["#{node[:datasyncprereqs][:tempdir]}"].each do |dir|
  log("create #{dir} directory if necessary") { level :debug }
  directory "#{dir}" do
    action :create
    not_if { File.exists?("#{dir}") }
    recursive true
  end
end

node[:datasyncprereqs][:installer].each do |m|
  remote_file "#{m[:name]}" do
    action :create
    not_if { File.exists?("#{node[:datasyncprereqs][:tempdir]}\\#{m[:name]}") }
    backup false
    source "#{m[:baseurl]}/#{m[:name]}"
    path "#{node[:datasyncprereqs][:tempdir]}\\#{m[:name]}"
  end
end

case node[:kernel][:machine]
  when "i386"
  node[:datasyncprereqs][:installer].each do |m|
    log("install #{m[:name]} if necessary") { level :debug }
    execute "#{m[:name]}" do
      action :run
      #only_if { WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:datasyncprereqs][:servicename]}"}).nil? }
      timeout 180
      command %Q(msiexec /i #{node[:datasyncprereqs][:tempdir]}\\#{m[:name]} /quiet /qn /norestart)
      #notifies :enable, "service[#{node[:datasyncprereqs][:servicename]}]"
    end
  end

  when "x86_64"
  # have not tested x86_64 at all
  node[:datasyncprereqs][:installer].each do |m|
    log("install #{node[:datasyncprereqs][:servicename]} if necessary") { level :debug }
    execute "#{m[:name]}" do
      action :run
      #only_if { WMI::Win32_Service.find(:first, :conditions => {:name => "#{node[:datasyncprereqs][:servicename]}"}).nil? }
      timeout 180
      command %Q(msiexec /i #{node[:datasyncprereqs][:tempdir]}\\#{m[:name]} /quiet /qn /norestart)
      #notifies :enable, "service[#{node[:datasyncprereqs][:servicename]}]"
    end
  end
end


log("end datasyncprereqs") { level :info }
