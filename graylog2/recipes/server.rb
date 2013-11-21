#
# Cookbook Name:: graylog2
# Recipe:: server
#
# Copyright 2010, Medidata Solutions Inc.
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

# Install MongoDB from 10gen repository
include_recipe "mongodb::10gen_repo"
include_recipe "mongodb::default"

# Install required APT packages
package "openjdk-7-jre"

# Create the release directory
directory "#{node[:graylog2][:basedir]}/rel" do
  mode 0755
  recursive true
end

# Download the elasticsearch dpkg

remote_file "elasticsearch_dpkg" do
    path "#{node[:graylog2][:basedir]}/rel/elasticsearch-#{node[:graylog2][:elasticsearch][:version]}.deb"
    source "#{node[:graylog2][:elasticsearch][:repo]}/elasticsearch-#{node[:graylog2][:elasticsearch][:version]}.deb"
    action :create_if_missing
end

dpkg_package "elasticsearch" do
    source "#{node[:graylog2][:basedir]}/rel/elasticsearch-#{node[:graylog2][:elasticsearch][:version]}.deb"
    version node[:graylog2][:elasticsearch][:version]
    action :install
end

# Download the desired version of Graylog2 server from GitHub
remote_file "download_server" do
  path "#{node[:graylog2][:basedir]}/rel/graylog2-server-#{node[:graylog2][:server][:version]}.tar.gz"
  source "#{node[:graylog2][:repo]}/graylog2-server/graylog2-server-#{node[:graylog2][:server][:version]}.tar.gz"
  action :create_if_missing
end

# Unpack the desired version of Graylog2 server
execute "tar zxf graylog2-server-#{node[:graylog2][:server][:version]}.tar.gz" do
  cwd "#{node[:graylog2][:basedir]}/rel"
  creates "#{node[:graylog2][:basedir]}/rel/graylog2-server-#{node[:graylog2][:server][:version]}/build_date"
  action :nothing
  subscribes :run, resources(:remote_file => "download_server"), :immediately
end

# Link to the desired Graylog2 server version
link "#{node[:graylog2][:basedir]}/server" do
  to "#{node[:graylog2][:basedir]}/rel/graylog2-server-#{node[:graylog2][:server][:version]}"
end

# Create graylog2.conf
template "/etc/graylog2.conf" do
  mode 0644
  notifies :restart, "service[graylog2]"
end

# Create init.d script
template "/etc/init.d/graylog2" do
  source "graylog2.init.erb"
  mode 0755
end

# Update the rc.d system
execute "update-rc.d graylog2 defaults" do
  creates "/etc/rc0.d/K20graylog2"
  action :nothing
  subscribes :run, resources(:template => "/etc/init.d/graylog2"), :immediately
end

# Service resource
service "elasticsearch" do
  supports :restart => true
  action [:enable, :start]
end

# Service resource
service "graylog2" do
  supports :restart => true
  action [:enable, :start]
end
