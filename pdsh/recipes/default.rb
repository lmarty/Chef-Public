#
# Cookbook Name:: pdsh
# Recipe:: default
#
# Copyright 2013, New Dream Network, LLC.
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

package 'pdsh' do
  action :install
end

if Chef::Config[:solo]
  Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
else
  nodes = search(:node, "chef_environment:#{node.chef_environment}")
  node_genders = Hash.new
  nodes.each do |n|
    node_roles = String.new
    n.roles.each do |role|
      x = node_roles << role << ","
      role_hosts = x
    end
    node_genders[n.hostname] = node_roles unless node_roles.empty?
  end

  template "/etc/genders" do
    source "genders.erb"
    user "root"
    group "root"
    mode 0644
    variables({
      :node_genders => node_genders
    })
  end
end
