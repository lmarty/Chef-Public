#
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: visualstudio
# Recipe:: uninstall
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
# http://msdn.microsoft.com/en-us/library/vstudio/ee225238.aspx
# Visual Studio can be enabled for customer uninstall on individual computers
# The value can be dword:00000001 for true, dword:00000000 for false.
# If the key is null or absent, this installation inherits the default setting of its Visual Studio edition, for example, Visual Studio Professional.

log("begin uninstall") { level :debug }
log("running uninstall") { level :info }

setup = "#{node['vs']['media']}\\#{node['vs']['setup']}"
execute setup do
  action :nothing
  timeout 1800
  command %Q(#{setup} #{node['vs']['uninstall']})
  ignore_failure true
end

ruby_block "uninstalling Visual Studio #{node['vs']['version']} #{node['vs']['product'].capitalize} if necessary" do
  block {}
  only_if do
    uninstall = false
    begin
      require 'win32/registry'
      raccess = ::Win32::Registry::KEY_READ
      regbase = "#{node['vs']['installreg']}"
      begin
        ::Win32::Registry::HKEY_LOCAL_MACHINE.open(regbase, raccess) do |reg|
          if "#{reg['Install']}" == '1'
            uninstall = true
          end
        end
      rescue
        uninstall = false
        # this rescue in case the key is nil should indicate that there is no need to uninstall
      end
    end
    uninstall
  end
  notifies :run, resources(:execute => setup), :immediately
  node.run_list.remove("recipe[visualstudio::default]") if node.run_list.include?("recipe[visualstudio::default]")
  node.run_list.remove("recipe[visualstudio::vs11.0]") if node.run_list.include?("recipe[visualstudio::vs11.0]")
end

log("end uninstall") { level :info }
