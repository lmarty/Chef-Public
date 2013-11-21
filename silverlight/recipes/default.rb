#
# Cookbook Name:: silverlight
# Recipe:: default
#
# Based on Doug MacEachern's (<dougm@vmware.com>) windows::dotnetfx.rb
#
# Copyright 2011, Joshua Timberman
# Copyright 2010, VMware, Inc.
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

distfile = ::File.basename(node['silverlight']['url'])
target   = File.join(Chef::Config[:file_cache_path], distfile)

remote_file target do
  source node['silverlight']['url']
  backup false
  action :create_if_missing
  notifies :run, "execute[#{target}]", :immediately
end

execute target do
  command %Q(#{target} /q #{node['silverlight']['options'].join(' ')})
  not_if do
    begin
      require 'win32/registry'
      Win32::Registry::HKEY_LOCAL_MACHINE.open('Software\Microsoft\Silverlight').keys
    rescue
      false
    end
  end
end
