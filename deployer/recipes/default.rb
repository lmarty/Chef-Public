#
# Cookbook Name:: deployer
# Recipe:: default
# Author:: Seth Vargo <sethvargo@gmail.com>
#
# Copyright 2012 Seth Vargo
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

if Chef::Config[:solo]
  return Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
end

# GRP deploy
group node['deployer']['group'] do
  gid       5000
end

# USER deploy
user node['deployer']['user'] do
  comment   'The deployment user'
  uid       5000
  gid       5000
  shell     '/bin/bash'
  home      node['deployer']['home']
  supports  :manage_home => true
end

# SUDO deploy
sudo node['deployer']['user'] do
  user      node['deployer']['user']
  group     node['deployer']['group']
  commands  ['ALL']
  host      'ALL'
  nopasswd  true
end

# DIR /home/deploy/.ssh
directory "#{node['deployer']['home']}/.ssh" do
  owner     node['deployer']['user']
  group     node['deployer']['group']
  mode      '0700'
  recursive true
end

# SEL users and deployers that can deploy to this node
query = "deploy:any OR deploy:#{node['fqdn']} OR deploy:#{node['ipaddress']}"
users = [:users, :deployers].collect do |data_bag|
  # Because the data_bag may not exist, wrap in a safe search
  begin
    search(data_bag, query)
  rescue Net::HTTPServerException
    []
  end
end.flatten

# TMPL /home/deploy/.ssh/authorized_keys
template "#{node['deployer']['home']}/.ssh/authorized_keys" do
  owner     node['deployer']['user']
  group     node['deployer']['group']
  mode      '0644'
  variables :users => users
  source    'authorized_keys.erb'
end
