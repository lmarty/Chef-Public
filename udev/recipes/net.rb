#
# Cookbook Name:: udev
# Recipe:: net
#
# Copyright 2012, Opscode, Inc.
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

#search for any apt-cacher-ng caching proxies
if Chef::Config[:solo]
  Chef::Log.warn("This recipe attempts to use search with data bags. Chef Solo does not support this.")
else
  begin
    udev_net = data_bag_item('udev', node.hostname)
    node['udev']['net'] = udev_net['net'] if udev_net
  rescue
    Chef::Log.info "no 'udev' data bag entry for '#{node.hostname}' found."
  end
end

template "/etc/udev/rules.d/70-persistent-net.rules" do
  source "70-persistent-net.rules.erb"
  mode "0644"
  owner "root"
  group "root"
end
