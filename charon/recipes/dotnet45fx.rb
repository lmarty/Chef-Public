#
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: charon
# Recipe:: dotnet45fx
#
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
# dotnet45 silent install command documented here:
# http://msdn.microsoft.com/en-us/library/vstudio/ee225238.aspx
#
log("begin dotnet45fx") { level :debug }
log("running dotnet45fx") { level :info }

exe = ::File.basename(node['dotnet45fx']['installer'])
cmd = "#{node['dotnet45fx']['tempdir']}\\#{exe}"

directory node['dotnet45fx']['tempdir'] do
  action :create
  not_if { File.exists?(node['dotnet45fx']['tempdir']) }
  recursive true
end

remote_file exe do
  action :nothing
  source node['dotnet45fx']['url']
  not_if { File.exists?(exe) }
  path cmd
  backup false
end

execute exe do
  action :nothing
  timeout 1800
  command %Q(#{cmd} /q /norestart /ChainingPackage "ADMINDEPLOYMENT")
  ignore_failure true
end

ruby_block "installing Microsoft .NET Framework v45 if necessary" do
  block {}
  only_if do
    install = true
    begin
      require 'win32/registry'
      raccess = ::Win32::Registry::KEY_READ
      regbase = 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full'
      begin
        ::Win32::Registry::HKEY_LOCAL_MACHINE.open(regbase, raccess) do |reg|
          if "#{reg['Release']}" == '378389'
            install = false
          end
        end
      rescue
        # rescue in case the key is nil, in which case we need to install
      end
    end
    install
  end
  notifies :create_if_missing, resources(:remote_file => exe), :immediately
  notifies :run, resources(:execute => exe), :immediately
end

log("end dotnet45fx") { level :info }
