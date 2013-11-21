#
# Cookbook Name:: lsyncd
# Recipe:: default
#
# Copyright 2012
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

package "lsyncd"

template "/etc/init.d/lsyncd" do
  source "lsyncd.init.erb"
  mode   "0755"
end

service "lsyncd" do
  supports :status => true, :restart => true
  action :enable
end


template "/etc/lsyncd.lua" do
  source "lsyncd.lua.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  notifies :restart, resources(:service => "lsyncd"), :delayed
end
