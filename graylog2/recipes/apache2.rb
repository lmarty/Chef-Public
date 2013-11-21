#
# Cookbook Name:: graylog2
# Recipe:: apache2
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

# Install Graylog2 web interface
include_recipe "graylog2::web_interface"

# Install Apache using the OpsCode community cookbook
include_recipe "apache2"

# Install gem dependencies
rbenv_gem "passenger" do
	ruby_version "#{node[:graylog2][:ruby_version]}"
	version "#{node[:graylog2][:passenger_version]}"
end

# Install packages to build Apache module:

# -- Curl development headers with SSL support
package "libcurl4-openssl-dev"

# -- Apache 2 development headers
package "apache2-threaded-dev"

# -- Apache Portable Runtime (APR) development headers
package "libapr1-dev"

# -- Apache Portable Runtime Utility (APU) development headers
package "libaprutil1-dev"

# Build the Apache module
bash "install-apache-module" do
  cwd "#{node[:graylog2][:basedir]}/web"
  code "source /etc/profile.d/rbenv.sh && yes | passenger-install-apache2-module"
  creates "/opt/rbenv/versions/#{node[:graylog2][:ruby_version]}/lib/ruby/gems/1.9.1/gems/passenger-#{node[:graylog2][:passenger_version]}/libout/apache2/mod_passenger.so"
  user "root"
  notifies :restart, "service[apache2]"
end

# Create an Apache vhost for the Graylog2 web interface
template "apache-vhost-conf" do
  path "/etc/apache2/sites-available/graylog2"
  source "graylog2.apache2.erb"
  mode 0644
end

# Remove the default vhost
apache_site "000-default" do
  enable false
end

# Enable the Graylog2 web interface vhost
apache_site "graylog2"