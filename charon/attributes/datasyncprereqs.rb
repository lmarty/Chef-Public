#
# Author:: Steven Craig <support@smashrun.com>
# Cookbook Name:: charon
# Attributes:: datasyncprereqs
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


default[:datasyncprereqs][:author_name] = "Steve Craig"
default[:datasyncprereqs][:author_email] = "support@smashrun.com"

case node[:platform]
when "windows"
  default[:datasyncprereqs][:databag_secret] = "C:\\Chef\\encrypted_data_bag_secret"

  # the [:servicename] dirs
  default[:datasyncprereqs][:tempdir] = Chef::Config[:file_cache_path].gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR)


  if node[:kernel][:machine] == "x86_64"
    default[:datasyncprereqs][:installer] = [
      { :name => 'SQLSysClrTypes.msi', :baseurl => "http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64" },
      { :name => 'SharedManagementObjects.msi', :baseurl => 'http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64' }
      ]
  else
    if node[:kernel][:machine] == "i386"
      default[:datasyncprereqs][:installer] = [
        { :name => 'SQLSysClrTypes.msi', :baseurl => "http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x86" },
        { :name => 'SharedManagementObjects.msi', :baseurl => 'http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x86' }
        ]
    end
  end

when "centos","redhat","fedora","ubuntu","debian","arch"
  default[:datasyncprereqs][:databag_secret] = "/etc/chef/encrypted_data_bag_secret"
end
