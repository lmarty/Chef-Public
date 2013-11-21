#
# Cookbook Name:: metarepo
# Recipe:: default
#
# Copyright 2012, Heavy Water Operations, LLC
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

node.default['ruby_installer']['package_name'] = "ruby1.9.3"

include_recipe "git"
include_recipe "ubuntu"
include_recipe "ruby_installer"
include_recipe "redis::server"

include_recipe "#{cookbook_name}::user"

directory node['metarepo']['home'] do
  owner node['metarepo']['user']
  group node['metarepo']['group']
end

git node['metarepo']['directory'] do
  repository node['metarepo']['git_url']
  revision node['metarepo']['git_branch']
  action node['metarepo']['git_action']
  user node['metarepo']['user']
  group node['metarepo']['group']
end

gem_package "bundler"

execute "metarepo: bundle" do
  command "bundle install --deployment"
  subscribes :run, resources(:git => node['metarepo']['directory']), :immediately
  cwd node['metarepo']['directory']
  user node['metarepo']['user']
  group node['metarepo']['group']
  creates File.join(node['metarepo']['directory'], ".bundle")
end

include_recipe "#{cookbook_name}::database"

execute "metarepo: database migrations" do
  command "bundle exec sequel -m ./migrations #{node['metarepo']['database']['db_connect']}"
  subscribes( :run,
              "postgresql_database_user[#{node['metarepo']['database']['user']}]",
              :immediately )
  cwd node['metarepo']['directory']
  user node['metarepo']['user']
  group node['metarepo']['group']
  action :nothing
end

template node['metarepo']['config_file'] do
  variables( :db_connect => node['metarepo']['database']['db_connect'],
             :pool_path => node['metarepo']['pool_path'],
             :repo_path => node['metarepo']['repo_path'],
             :upstream_path => node['metarepo']['upstream_path'],
             :uri => node['metarepo']['uri'],
             :gpg_key => node['metarepo']['gpg_key']
             )
  owner node['metarepo']['user']
  group node['metarepo']['group']
  mode 00644
  notifies :restart, "service[metarepo]"
end

runit_service "resque"
runit_service "metarepo"
