#
# Author:: Sachin Sagar Rai <millisami@gmail.com>
# Cookbook Name:: phpbb
# Provider:: instance
#
# Copyright (C) 2013 Millisami
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :create do

  node.set_unless['mysql']['server_root_password'] = 'rootpass'
  node.set_unless['mysql']['server_debian_password'] = 'rootpass'
  node.set_unless['mysql']['server_repl_password'] = 'rootpass'

  run_context.include_recipe "apt"
  run_context.include_recipe "php::default"
  run_context.include_recipe "apache2"
  run_context.include_recipe "php::module_mysql"
  run_context.include_recipe "apache2::mod_php5"
  run_context.include_recipe "mysql::server"
  run_context.include_recipe "mysql::ruby"

  package "imagemagick" do
    action :install
  end

  package "php5-gd" do
    action :install
  end

  d = directory new_resource.doc_root do
    owner node['phpbb']['app']['user']
    group node['phpbb']['app']['group']
    mode "0775"
    action :nothing
    recursive true
  end
  d.run_action(:create)
  new_resource.updated_by_last_action(true) if d.updated_by_last_action?

  remote_file "#{Chef::Config[:file_cache_path]}/phpBB-#{new_resource.version}.tar.bz2" do
    source "https://www.phpbb.com/files/release/phpBB-#{new_resource.version}.tar.bz2"
    mode "0644"
    action :create_if_missing
  end

  execute "Untar phpBB" do
    cwd new_resource.doc_root
    command "tar --strip-components 1 -xjf #{Chef::Config[:file_cache_path]}/phpBB-#{new_resource.version}.tar.bz2"
    creates "#{new_resource.doc_root}/viewforum.php"
  end

  execute "set permissions" do
    command "chown -R #{node[:apache][:user]}:#{node[:apache][:group]} #{new_resource.doc_root}"
    action :run
  end

  mysql_connection_info = {:host => "localhost",
                           :username => 'root',
                           :password => node['mysql']['server_root_password']}

  mysql_database new_resource.db_name do
    connection mysql_connection_info
    action :create
  end

  # grant all privileges on all tables for this db
  mysql_database_user new_resource.db_user do
    connection mysql_connection_info
    database_name new_resource.db_name
    privileges [:all]
    password new_resource.db_password
    action [:create, :grant]
  end

  document_root = new_resource.doc_root
  domain_name = new_resource.domain

  web_app new_resource.name do
    cookbook "phpbb"
    template "phpbb.conf.erb"
    docroot "#{document_root}"
    server_name domain_name
    server_aliases [node['fqdn']]
  end
end