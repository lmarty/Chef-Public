#
# Author:: Steven Craig <support@smashrun.com>
# Cookbook Name:: charon
# Attributes:: datasync
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


default[:datasync][:author_name] = "Steve Craig"
default[:datasync][:author_email] = "support@smashrun.com"

case node[:platform]
when "windows"
  default[:datasync][:databag_secret] = "C:\\Chef\\encrypted_data_bag_secret"
  default[:datasync][:tempdir] = Chef::Config[:file_cache_path].gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR)
  # the [:servicename] information
  default[:datasync][:servicename] = "Microsoft SQL Data Sync"
  default[:datasync][:servicestatus] = "start"

  # as per http://msdn.microsoft.com/en-us/library/windowsazure/hh667308 "retain current sync group info"
  # it looks like "AgentConfigData.xml" will be the template file
  #
  default[:datasync][:installer] = "SQLDataSyncAgent-Preview-ENU.msi"

  if node[:kernel][:machine] == "x86_64"
    default[:datasync][:url] = "http://download.microsoft.com/download/C/B/3/CB35F695-5A32-4458-ACDB-E701250CEA1E/#{node[:datasync][:installer]}"
  else
    if node[:kernel][:machine] == "i386"
      default[:datasync][:url] = "http://download.microsoft.com/download/C/B/3/CB35F695-5A32-4458-ACDB-E701250CEA1E/#{node[:datasync][:installer]}"
    end
  end

when "centos","redhat","fedora","ubuntu","debian","arch"
  default[:datasync][:databag_secret] = "/etc/chef/encrypted_data_bag_secret"
end
