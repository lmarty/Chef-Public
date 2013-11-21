#
# Cookbook Name:: asgard
# Recipe:: apache
#
# Copyright 2013, StudyBlue, Inc.
#
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


# == APACHE SETUP
#
directory "/mnt/log" do
  action :create
  owner "root"
  group "root"
  mode "755"
end

include_recipe "apache2"
include_recipe "apache2::mod_deflate"
include_recipe "apache2::mod_expires"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"
include_recipe "apache2::mod_rewrite"

directory "/mnt/log/httpd" do
  action :create
  owner "apache"
  group "apache"
  mode "775"
end

directory "/var/log/httpd" do
  action :delete
  recursive true
  not_if { File.symlink?("/var/log/httpd") }
end

link "/var/log/httpd" do
  to "/mnt/log/httpd"
  notifies :restart, resources(:service => "apache2")
end

apache_site "000-default" do
  enable false
end

template "#{node[:apache][:dir]}/sites-available/asgard.conf" do
  source "asgard.apache2.conf.erb"
  mode 0644

  if ::File.symlink?("#{node[:apache][:dir]}/sites-enabled/asgard.conf")
    notifies :reload, resources(:service => "apache2")
  end
end

apache_site "asgard.conf"

# == ASGARD SETUP
#
include_recipe "asgard::server"