#
# Cookbook Name:: TestSwarm
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "mysql::server"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['testswarm']['db']['password'] = secure_password

remote_file "#{Chef::Config[:file_cache_path]}/testswarm.zip" do
  source "https://nodeload.github.com/jquery/testswarm/zipball/master"
  mode "0644"
end

directory "#{node['testswarm']['dir']}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

package "curl"
package "unzip"

execute "unzip testswarm" do
  cwd Chef::Config[:file_cache_path]
  command "unzip -o testswarm.zip -d ./ && mv jquery-testswarm-*/* #{node['testswarm']['dir']}"
  creates "#{node['testswarm']['dir']}/index.php"
  action :run
end

template "#{node['mysql']['conf_dir']}/testswarm.sql" do
  source "testswarm.sql.erb"
  owner "root"
  group "root"
  mode "0600"
  variables(
    :db_name => node['testswarm']['db']['name'],
    :db_user => node['testswarm']['db']['user'],
    :db_pass => node['testswarm']['db']['password']
  )
  notifies :run, "execute[mysql-creates-db-and-privileges]", :immediately
end

execute "mysql-creates-db-and-privileges" do
  cwd node['mysql']['conf_dir']
  command "mysql -u root -p#{node['mysql']['server_root_password'].dump} < testswarm.sql"
  action :nothing
end

template "#{node['testswarm']['dir']}/.htaccess" do
    source "htaccess.erb"
    mode "0644"
    variables(
      :url_path => node['testswarm']['url_path']
    )
end

template "#{node['testswarm']['dir']}/config/testswarm.json" do
    source "testswarm.json.erb"
    mode "0644"
    variables(
      :db_name => node['testswarm']['db']['name'],
      :db_user => node['testswarm']['db']['user'],
      :db_pass => node['testswarm']['db']['password'],
      :url_path => node['testswarm']['url_path']
    )
end

execute "make cache dir writable" do
  cwd node['testswarm']['dir']
  command "chmod 777 cache"
  action :run
end

execute "preseed db" do
  cwd node['testswarm']['dir']
  command "php scripts/dbInstall.php > config/install.log"
  creates "#{node['testswarm']['dir']}/config/install.log"
  action :run
end

execute "create robots.txt" do
  cwd node['testswarm']['dir']
  command "cp config/robots-sample.txt robots.txt"
  creates "#{node['testswarm']['dir']}/robots.txt"
  action :run
end

template "#{node['apache']['dir']}/conf.d/testswarm.conf" do
    source "apache2.conf.erb"
    mode "0644"
    variables(
      :install_dir => node['testswarm']['dir']
    )
end

service "apache2" do
  supports :restart => true, :reload => true
  action :enable
end

cron "cleaning duties" do
  command "curl -s http://localhost#{node['testswarm']['url_path']}/api.php?action=cleanup > /dev/null"
end
