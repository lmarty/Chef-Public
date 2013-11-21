#
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: visualstudio
# Attributes:: vs2012
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
# Detection subkeys in the registry let you determine whether a Visual Studio product is already installed on a computer.
# Servicing subkeys let you detect whether a service release of the product is installed.
#
# NOTE! These attributes are NOT intended to be changed!
# Please set attributes inside 'default.rb'!

case node['platform']
when "windows"
  case
    node['vs']['version']
  when '11.0'
    default['vs']['setup'] = "vs_#{node['vs']['product']}.exe"
    default['vs']['install'] = "/AdminFile #{node['vs']['tempdir']}\\#{node['vs']['deploy']} /ProductKey #{node['vs']['productkey']} /passive /norestart /log #{node['vs']['tempdir']}\\vs_#{node['vs']['product']}_#{node['vs']['version']}-install.log"
    default['vs']['uninstall'] = "/ProductKey #{node['vs']['productkey']} /passive /Uninstall /log #{node['vs']['tempdir']}\\vs_#{node['vs']['product']}_#{node['vs']['version']}-install.log"
    if node['kernel']['machine'] == 'x86_64'
      default['vs']['installreg'] = "SOFTWARE\\Wow6432Node\\Microsoft\\DevDiv\\vs\\Servicing\\#{node['vs']['version']}\\#{node['vs']['product']}\\#{node['vs']['lcid']}"
      default['vs']['updatereg'] = "SOFTWARE\\Wow6432Node\\Microsoft\\DevDiv\\vs\\Servicing\\#{node['vs']['version']}\\#{node['vs']['product']}\\#{node['vs']['lcid']}\\UpdateVersion"
      default['vs']['feedbackreg'] = "SOFTWARE\\Wow6432Node\\Microsoft\\VSCommon\\#{node['vs']['version']}\\SQM"
    else
      default['vs']['installreg'] = "SOFTWARE\\Microsoft\\DevDiv\\vs\\Servicing\\#{node['vs']['version']}\\#{node['vs']['product']}\\#{node['vs']['lcid']}"
      default['vs']['installreg'] = "SOFTWARE\\Microsoft\\DevDiv\\vs\\Servicing\\#{node['vs']['version']}\\#{node['vs']['product']}\\#{node['vs']['lcid']}\\UpdateVersion"
      default['vs']['feedbackreg'] = "SOFTWARE\\Microsoft\\VSCommon\\#{node['vs']['version']}\\SQM"
    end
  end
end
