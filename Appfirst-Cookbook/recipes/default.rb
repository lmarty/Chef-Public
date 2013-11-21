#
# Cookbook Name:: appfirst
# Recipe:: default
#
# Copyright 2012, Yipit.com
#
# All rights reserved - Do Not Redistribute
#

appfirst_package = "#{node['appfirst']['tmp_file_location']}/#{node['appfirst']['package']}"

node['appfirst']['pre_packages'].each do |pkg|
  package pkg do
    action :install
  end
end

http_request "Check Appfirst Modified Time" do
	message ""
	url "http://wwws.appfirst.com/packages/initial/#{node['appfirst']['appfirst_account_id']}/#{node['appfirst']['package']}"
	action :head
	if File.exists?(appfirst_package)
		headers "If-Modified-Since" => File.mtime(appfirst_package).httpdate
	end
	notifies :create, "remote_file[appfirst]", :immediately
end

remote_file "appfirst" do
	path appfirst_package
	source "http://wwws.appfirst.com/packages/initial/#{node['appfirst']['appfirst_account_id']}/#{node['appfirst']['package']}"
	# Don't want our run to fail if the endpoint is having temporary issues.
	ignore_failure true
	action :nothing
	notifies :install, "package[appfirst]", :immediately
end

package "appfirst" do
  source appfirst_package
  provider node['appfirst']['provider']
  action :nothing
  notifies :restart, "service[afcollector]"
end
  
service "afcollector" do
  supports :restart => true, :start => true
  action :nothing
end
