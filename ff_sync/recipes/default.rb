#
# Cookbook Name:: ff_sync
# Recipe:: default
#
# Copyright 2012, computerlyrik
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

packages = %w(python-dev mercurial sqlite3 python-virtualenv)

packages.each do |pkg|
  package pkg do
    action :install
  end
end

############ CHECKOUT, UPDATE && BUILD MOZILLA SYNC
include_recipe "mercurial"
execute "ff checkout" do
  command "hg clone https://hg.mozilla.org/services/server-full #{node['ff_sync']['server_dir']}"
  not_if {::File.exists?(node['ff_sync']['server_dir'])}
  action :run
end

execute "ff update" do
  command "hg pull && hg update"
  action :nothing #TODO cmd shellout
end

execute "make build" do
  cwd node['ff_sync']['server_dir']
  action :nothing
  subscribes :run, resources(:execute => "ff checkout")
  subscribes :run, resources(:execute => "ff update")
end

############ SET UP PYTHON AUTHENTIFICATION
package "libldap-dev"
package "libsasl2-dev"
execute "bin/easy_install python-ldap" do
  cwd node['ff_sync']['server_dir']
  subscribes :run, resources(:execute => "ff checkout")
end

############ SET UP MYSQL
node.set['mysql']['bind_address'] = "127.0.0.1"
include_recipe "mysql::server"
include_recipe "database::mysql"

mysql_connection_info = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}

node.set_unless['ff_sync']['mysql_password'] = secure_password

mysql_database_user node['ff_sync']['mysql_user'] do
  password  node['ff_sync']['mysql_password']
  database_name node['ff_sync']['mysql_user']
  connection mysql_connection_info
  action :grant
end

mysql_database node['ff_sync']['mysql_user'] do
  connection mysql_connection_info
  action :create
end

############ SET UP MYSQL-PYTHON CONNECTOR
execute "bin/easy_install mysql-python" do
  cwd node['ff_sync']['server_dir']
  subscribes :run, resources(:execute => "ff checkout")
end

############ SET UP GUNICORN
execute "bin/easy_install gunicorn" do
  cwd node['ff_sync']['server_dir']
  subscribes :run, resources(:execute => "ff checkout")
end

############ SET UP APPLICATION CONFIGURATION & START SERVICE
template "#{node['ff_sync']['server_dir']}/etc/sync.conf" do
  variables ({"ldap_server" => search(:node, "recipes:openldap\\:\\:users && domain:#{node['domain']}").first})
end

template "#{node['ff_sync']['server_dir']}/development.ini"

cmd = "#{node['ff_sync']['server_dir']}/bin/paster serve #{node['ff_sync']['server_dir']}/development.ini"
Chef::Log.info(cmd)
service "sync" do
  start_command "#{cmd} --daemon --log-file=/var/log/ff_sync.log"
  stop_command "#{cmd} --stop-daemon"
  reload_command "#{cmd} --reload"
  supports :start => true, :stop => true, :reload => true
  action :start
  subscribes :reload, resources(:template => "#{node['ff_sync']['server_dir']}/development.ini")
  subscribes :reload, resources(:template => "#{node['ff_sync']['server_dir']}/etc/sync.conf")
end

############ SET UP & START WEBSERVER :: TODO
#include_recipe "nginx"
#template "#{node['nginx']['dir']}/sites-available/nginx_sync"
#nginx_site "nginx_sync" do
#  enable true
#end
#nginx_site "default" do
#  enable false
#end
