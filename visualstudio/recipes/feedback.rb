#
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: visualstudio
# Recipe:: feedback
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
# Visual Studio can be enabled for customer feedback on individual computers
# The value can be dword:00000001 for true, dword:00000000 for false.
# If the key is null or absent, this installation inherits the default setting of its Visual Studio edition, for example, Visual Studio Professional.

log("begin feedback") { level :debug }
log("running feedback") { level :info }

ruby_block "write_vs_feedback_setting" do
  block {
    require 'win32/registry'
    waccess = ::Win32::Registry::KEY_WRITE
    regbase = "#{node['vs']['feedbackreg']}"
    begin
      ::Win32::Registry::HKEY_LOCAL_MACHINE.open(regbase, waccess) do |reg|
        reg['Optin', ::Win32::Registry::REG_DWORD] = "#{node['vs']['feedback']}"
      end
    rescue
      key = ::Win32::Registry::HKEY_LOCAL_MACHINE.create("#{node['vs']['feedbackreg'].gsub(/Wow6432Node\\/,'')}")
      key.write('Optin', ::Win32::Registry::REG_DWORD, "#{node['vs']['feedback'].to_s}")
      key.close
    end
  }
  action :nothing
end

ruby_block "setting Visual Studio #{node['vs']['version']} #{node['vs']['product']} Feedback Setting correctly if necessary" do
  block {}
  only_if do
    install = true
    begin
      require 'win32/registry'
      raccess = ::Win32::Registry::KEY_READ
      regbase = "#{node['vs']['feedbackreg']}"
      change = true
      begin
        ::Win32::Registry::HKEY_LOCAL_MACHINE.open(regbase, raccess) do |reg|
          setting = "#{reg['Optin']}"
          if setting == "#{node['vs']['feedback']}"
            change = false
          else
            change = true
          end
        end
      rescue
        # rescue in case the key is nil, in which case we need to set it
      end
    end
    change
  end
  notifies :create, "ruby_block[write_vs_feedback_setting]", :immediately
end

log("end feedback") { level :info }
