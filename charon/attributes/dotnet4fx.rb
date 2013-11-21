#
# Credit to the author of the original dotnet recipe
# Author:: Doug MacEachern <dougm@vmware.com>
# Modified and extended by Smashrun, Inc.
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: charon
# Attributes:: dotnet4fx
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

case node['platform']
when "windows"
  default['dotnet4fx']['tempdir'] = Chef::Config['file_cache_path'].gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR)
  default['dotnet4fx']['installdir'] = "#{node['kernel']['os_info']['windows_directory']}\\Microsoft.NET\\Framework\\v4.0.30319"

  if node['kernel']['machine'] == "x86_64"
    default['dotnet4fx']['url'] =
      "http://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe"
    default['dotnet4fx']['installer'] = "dotNetFx40_Full_x86_x64.exe"
  else
    default['dotnet4fx']['url'] = "http://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe"
    default['dotnet4fx']['installer'] = "dotNetFx40_Full_x86_x64.exe"
  end
end
