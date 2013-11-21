#
# Author:: Thorsten Klein (<cookbooks@perlwizard.de>)
# Cookbook Name:: windirstat
# Recipe:: default
#
# Copyright 2013. Thorsten Klein
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

if platform?("windows")

  install_dir = win_friendly_path(node[:windirstat][:home])

  windows_package node[:windirstat][:package_name] do
    source node[:windirstat][:url]
    checksum node[:windirstat][:checksum]
    options "/S /D=#{install_dir}"
    action :install
  end
  
else
  Chef::Log.warn('WinDirStat can only be installed on the Windows platform.')
end