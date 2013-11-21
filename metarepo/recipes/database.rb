#
# Cookbook Name:: metarepo
# Recipe:: database
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

include_recipe "postgresql::server"
include_recipe "database::postgresql"

# This could be a search
postgresql_connection_info = {
  :host => node['metarepo']['database']['hostname'],
  :port => 5432,
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

postgresql_database node['metarepo']['database']['name'] do
  connection postgresql_connection_info
  action :create
end

postgresql_database node['metarepo']['database']['name'] do
  connection postgresql_connection_info
  template 'DEFAULT'
  encoding 'DEFAULT'
  tablespace 'DEFAULT'
  connection_limit '-1'
  owner 'postgres'
  action :create
end

Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

node.set_unless['metarepo']['database']['password'] = secure_password
node.default['metarepo']['database']['db_connect'] =
  [
   "postgres://",
   node['metarepo']['database']['user'],
   ":",
   node['metarepo']['database']['password'],
   "@",
   node['metarepo']['database']['hostname'],
   "/",
   node['metarepo']['database']['name']
  ].join

postgresql_database_user node['metarepo']['database']['user'] do
  connection postgresql_connection_info
  password node['metarepo']['database']['password']
  database_name node['metarepo']['database']['name']
  host node['metarepo']['database']['host']
  # privileges node['metarepo']['database']['privileges']
  action [:create, :grant]
end
