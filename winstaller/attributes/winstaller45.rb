#
# Author:: Steven Craig <support@smashrun.com>
# Cookbook Name:: smashrun
# Attributes:: winstaller45
#
# Copyright 2012, Smashrun, Inc.
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

# these are standard
default['winstaller']['author_name'] = "Steve Craig"
default['winstaller']['author_email'] = "support@smashrun.com"

case node['platform']
when "windows"
  default['winstaller']['databag_secret'] = "C:\\Chef\\encrypted_data_bag_secret"
  default['winstaller']['tempdir'] = Chef::Config['file_cache_path'].gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR)
  default['winstaller']['servicename'] = "msiserver"
  default['winstaller']['servicestatus'] = "stop"
  default['winstaller']['baseurl'] = "http://download.microsoft.com/download/2/6/1/261fca42-22c0-4f91-9451-0e0f2e08356d"
  default['winstaller']['installer'] = "#{node['winstaller']['prefix']}#{node['winstaller']['msarch']}.#{node['winstaller']['suffix']}"
  default['winstaller']['url'] = "#{node['winstaller']['baseurl']}/#{node['winstaller']['installer']}"

  case node['kernel']['os_info']['version']
    when "5.2.3790"
      default['winstaller']['prefix'] = "WindowsServer2003-KB942288-v4-"
      default['winstaller']['suffix'] = "exe"
      case node['kernel']['machine']
        when "x86_64"
          default['winstaller']['msarch'] = "x64"
        when "i386"
          default['winstaller']['msarch'] = "x86"
  #      no Itanium systems to test with
  #      when "IA64"
  #        default['winstaller']['msarch'] = "IA64"
      end
    when /^6\.*/
      default['winstaller']['prefix'] = "Windows6.0-KB942288-v2-"
      default['winstaller']['suffix'] = "msu"
      case node['kernel']['machine']
        when "x86_64"
          default['winstaller']['msarch'] = "x64"
        when "i386"
          default['winstaller']['msarch'] = "x86"
  #      no Itanium systems to test with
  #      when "IA64"
  #        default['winstaller']['msarch'] = "IA64"
      end
  end

when "centos","redhat","fedora","ubuntu","debian","arch"
  default['winstaller']['databag_secret'] = "/etc/chef/encrypted_data_bag_secret"
end
