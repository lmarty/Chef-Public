#
# Credit to the author of the original dotnet recipe
# Author:: Doug MacEachern <dougm@vmware.com>
# Modified and extended by Smashrun, Inc.
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: charon
# Recipe:: dotnet4fx
#
# Copyright 2010, VMware, Inc.
# Copyright 2013, Smashrun, Inc.
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
log("begin dotnet4fx") { level :debug }
log("running dotnet4fx") { level :info }

exe = ::File.basename(node['dotnet4fx']['installer'])
cmd = "#{node['dotnet4fx']['tempdir']}\\#{exe}"

directory node['dotnet4fx']['tempdir'] do
  action :create
  not_if { File.exists?(node['dotnet4fx']['tempdir']) }
  recursive true
end

remote_file exe do
  action :nothing
  source node['dotnet4fx']['url']
  not_if { File.exists?(exe) }
  path cmd
  backup false
end

execute exe do
  action :nothing
  timeout 1800
  command %Q(#{cmd} /q /norestart)
  ignore_failure true
end

ruby_block "installing Microsoft .NET Framework v4 if necessary" do
  block {}
  only_if do
    require 'win32/registry'
    begin
      #detect for v4 http://msdn.microsoft.com/library/ee942965%28v=VS.100%29.aspx#command_line_options
      ::Win32::Registry::HKEY_LOCAL_MACHINE.open('Software\Microsoft\NET Framework Setup\NDP').keys.select {|subkey|
        subkey =~ /^v[4]/
      }.empty?
    rescue
      true
    end
  end

  notifies :create_if_missing, resources(:remote_file => exe), :immediately
  notifies :run, resources(:execute => exe), :immediately
end

log("end dotnet4fx") { level :info }
