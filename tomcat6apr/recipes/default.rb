#
# Cookbook Name:: tomcat6apr
# Recipe:: default
#
# Copyright 2010, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "debian::testing"
include_recipe "java_sun"

u = execute "apt-get update" do
	command "apt-get update"
	only_if "[ $((`date +%s` - `stat -c%Y /etc/apt/sources.list.d/testing.list`)) -lt 3600 ]"
end

u.run_action(:run)

package "libtcnative-1" do
	version "1.1.20-1"
	options "-ttesting"	
	action :install
end

package "tomcat6" do
	action :install
	options "-ttesting"	
end

package "jsvc" do
	version "1.0.2-2"
	options "-ttesting"
	action :install
end

if (node[:tomcat6apr][:manager_app_enabled])
	package "tomcat6-admin" do
		action :install
		options "-ttesting"	
	end
else
	package "tomcat6-admin" do
		action :remove
	end
end

service "tomcat6" do
	supports :status => true, :restart => true, :reload => false
	action [ :enable, :start ]
end

template "/etc/tomcat6/server.xml" do
	source "server.xml.erb"
	mode "0644"
	notifies :restart, resources(:service => "tomcat6"), :delayed
end

tomcat_admins= []
admins = data_bag('admins')
admins.each do |uname|
	admin = data_bag_item('admins', uname)
	tomcat_admins << {'id'=>admin['id'], 'password'=>admin['password']}
end

template "/etc/tomcat6/tomcat-users.xml" do
	source "tomcat-users.xml.erb"
	mode "0644"
	variables(
		:users => tomcat_admins 
	) 
	notifies :restart, resources(:service => "tomcat6"), :delayed
end

template "/etc/tomcat6/policy.d/03catalina.policy" do
	source "03catalina.policy.erb"
	mode "0644"
	variables(
		:apps => data_bag('tomcat_apps')
	)
  notifies :restart, resources(:service => "tomcat6"), :delayed
end

template "/etc/default/tomcat6" do
	source "etc-default-tomcat6.erb"
	mode "0644"
	notifies :restart, resources(:service => "tomcat6"), :delayed
end

template "/etc/init.d/tomcat6" do
	source "init-tomcat6.erb"
	mode "0755"
	notifies :restart, resources(:service => "tomcat6"), :delayed
end


reboot = execute "restart server" do
	command "reboot"
	action :nothing
end


#Disable IPv6
if (! tagged?('REBOOTED') && (node[:tomcat6apr][:with_ssl] || node[:tomcat6apr][:http_port] < 1025 || node[:tomcat6apr][:ssl_port] < 1025))
	cookbook_file "/etc/modprobe.d/00local" do
		source "00local"
		notifies :run, resources(:execute => "restart server"),:delayed
	end
	tag('REBOOTED')
end	
