#
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: visualstudio
# Attributes:: default
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
# when default['vs']['version'] = '2012'
# default['vs']['product'] is one of only, ['ultimate', 'premium', 'professional']
# 
# IMPORTANT! To set default['vs']['lcid'] properly
# LCID chart here: http://msdn.microsoft.com/en-us/goglobal/bb964664.aspx
#
# NOTE! Visual Studio 2012 is actually "version 11.0"
#
# this cookbook does not yet "update" Visual Studio
#

default['vs']['author_name'] = "Steve Craig"
default['vs']['author_email'] = "support@smashrun.com"

case platform
when "windows"
  default['vs']['tempdir'] = Chef::Config['file_cache_path'].gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR)
  default['vs']['lcid'] = '1033' # 'English - United States'
  default['vs']['feedback'] = '0' # (dword:00000001 for true, dword:00000000 for false)
  # change 'media' to point to your install media location (could be network share, iso image, etc)
  default['vs']['media'] = "R:"
  default['vs']['productkey'] = 'x-y-z'

  case node['kernel']['machine']
  when "x86_64"
    default['vs']['version'] = '11.0'
    default['vs']['product'] = 'professional'
    default['vs']['deploy'] = 'AdminDeployment.xml'
    default['vs']['deploy_template'] = "#{node['vs']['deploy']}.erb"
  when "i386"
    default['vs']['version'] = '11.0'
    default['vs']['product'] = 'professional'
    default['vs']['deploy'] = 'AdminDeployment.xml'
    default['vs']['deploy_template'] = "#{node['vs']['deploy']}.erb"
  end
end