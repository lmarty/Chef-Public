#
# Cookbook Name:: selenium-grid
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# if doesn't already exist, get https://selenium.googlecode.com/files/selenium-server-standalone-2.33.0.jar

if File.exists?("#{Chef::Config[:file_cache_path]}/selenium-server-standalone-2.33.0.jar")
	remote_file "#{Chef::Config[:file_cache_path]}/selenium-server-standalone-2.33.0.jar" do
	  source "https://selenium.googlecode.com/files/selenium-server-standalone-2.33.0.jar"
	  mode 0644
	end
end

# ensure port 4444 is accessible
# ensure that java is installed