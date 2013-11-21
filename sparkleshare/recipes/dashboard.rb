#
# Cookbook Name:: sparkleshare
# Recipe:: dashboard
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

include_recipe "sparkleshare"

package "redis-server"

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['sparkleshare']['dashboard']['session_secret'] = secure_password

git node['sparkleshare']['dashboard']['dir'] do
  user node['sparkleshare']['user']
  repository node['sparkleshare']['dashboard']['repo']
  action :sync
end

node.set['nodejs']['install_method'] = "package"
include_recipe "npm"
%w{express@2.5 express-messages i18n jade connect-redis redis sass mime}.each do |pkg|
  npm_package pkg
  #try
  #do
  #  path  node['sparkleshare']['dashboard']['dir']
  #  action :install_local
  #end
end

template "#{node['sparkleshare']['dashboard']['dir']}/config.js"

node_cmd = "/usr/bin/node"
app = "#{node['sparkleshare']['dashboard']['dir']}/app.js"

#for some reason stop-start does not work
service "sparkleshare_dashboard" do
  start_command "nohup #{node_cmd} #{app} > /var/log/sparkleshare_dashboard.log &"
  stop_command "killall #{node_cmd}"
  supports :start => true, :stop => true
  action :start
  subscribes :stop, resources(:git =>  node['sparkleshare']['dashboard']['dir'])
  subscribes :start, resources(:git =>node['sparkleshare']['dashboard']['dir'])
  subscribes :stop, resources(:template => "#{node['sparkleshare']['dashboard']['dir']}/config.js")
  subscribes :start, resources(:template => "#{node['sparkleshare']['dashboard']['dir']}/config.js")
end

#TODO
#integrate into nginx
