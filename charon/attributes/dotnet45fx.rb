#
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: charon
# Attributes:: dotnet45fx
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

case node['platform']
when "windows"
  default['dotnet45fx']['tempdir'] = Chef::Config['file_cache_path'].gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR)

  if node['kernel']['machine'] == "x86_64"
    default['dotnet45fx']['url'] =
      "http://download.microsoft.com/download/b/a/4/ba4a7e71-2906-4b2d-a0e1-80cf16844f5f/dotnetfx45_full_x86_x64.exe"
    default['dotnet45fx']['installer'] = "dotnetfx45_full_x86_x64.exe"
    default['dotnet45fx']['installdir'] =   "#{node['kernel']['os_info']['windows_directory']}\\Microsoft.NET\\Framework64\\v4.0.30319"
  else
    default['dotnet45fx']['url'] = "http://download.microsoft.com/download/b/a/4/ba4a7e71-2906-4b2d-a0e1-80cf16844f5f/dotnetfx45_full_x86_x64.exe"
    default['dotnet45fx']['installer'] = "dotnetfx45_full_x86_x64.exe"
    default['dotnet45fx']['installdir'] = "#{node['kernel']['os_info']['windows_directory']}\\Microsoft.NET\\Framework\\v4.0.30319"
  end
end
