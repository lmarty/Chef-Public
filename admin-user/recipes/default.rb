#
# Cookbook Name:: admin-user
# Recipe:: default
#
# Copyright 2013, HipSnip Ltd.
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

# Level the playing field
node.set['authorization']['sudo']['include_sudoers_d'] = true
include_recipe "sudo::default"

user_data = data_bag_item(node['admin-user']['data_bag'], node['admin-user']['user'])
user_home = "/home/#{node['admin-user']['user']}"

ssh_keys = if node['admin-user']['authorized_keys'].empty? then user_data['authorized_keys'].values
           else user_data['authorized_keys'].values_at(*node['admin-user']['authorized_keys']).compact
           end

group node['admin-user']['group'] do
  gid 3000
end

user node['admin-user']['user'] do
  comment 'Shared admin user account'
  uid 3000
  gid 3000
  shell '/bin/bash'
  home user_home
  supports :manage_home => true
end

directory "#{user_home}/.ssh" do
  owner     node['admin-user']['user']
  group     node['admin-user']['group']
  mode      '0700'
  recursive true
end

template "#{user_home}/.ssh/authorized_keys" do
  owner     node['admin-user']['user']
  group     node['admin-user']['group']
  mode      '0644'
  variables :ssh_keys => ssh_keys
  source    'authorized_keys.erb'
end

sudo node['admin-user']['user'] do
  user      node['admin-user']['user']
  group     node['admin-user']['group']
  commands  ['ALL']
  host      'ALL'
  nopasswd  true
end