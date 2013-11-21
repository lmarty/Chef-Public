#
# Cookbook Name:: chef-zero
# Recipe:: default
#
# Copyright 2013, Seth Vargo <sethvargo@gmail.com>
# Copyright 2013, Opscode, Inc.
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

include_recipe 'build-essential'

script = "/etc/init.d/#{node['chef-zero']['daemon']}"

# This is a chef_gem because we actually want to run this from inside Chef
chef_gem 'chef-zero' do
  version   node['chef-zero']['version']
  only_if   { node['chef-zero']['install'] }
end

template script do
  owner     'root'
  group     'root'
  mode      '0755'
  source    'init.erb'
  variables(
    :command => ChefZeroCookbook::Helpers.command(node)
  )
end

service node['chef-zero']['daemon'] do
  supports          [:start, :stop, :restart]
  start_command     "#{script} start"
  stop_command      "#{script} stop"
  restart_command   "#{script} restart"
  action            [:enable, :start]
  only_if           { node['chef-zero']['start'] }
end
