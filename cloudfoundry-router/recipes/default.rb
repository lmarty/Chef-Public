#
# Cookbook Name:: cloudfoundry-router
# Recipe:: default
#
# Copyright 2012-2013, ZephirWorks
# Copyright 2012, Trotter Cashion
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

node.default['cloudfoundry_router']['ruby_version'] = node['cloudfoundry']['ruby_version']
ruby_ver = node['cloudfoundry_router']['ruby_version']
ruby_path = ruby_bin_path(ruby_ver)

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby ruby_ver

cloudfoundry_source "router" do
  path          node['cloudfoundry_router']['vcap']['install_path']
  repository    node['cloudfoundry_router']['vcap']['repo']
  reference     node['cloudfoundry_router']['vcap']['reference']
  ruby_version  ruby_ver
end

include_recipe "cloudfoundry-nginx"
include_recipe "cloudfoundry-router::lua_modules"

template File.join(node['nginx']['dir'], "sites-available", "router") do
  source "nginx.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  variables :lua_package_path => File.join(node['cloudfoundry_router']['vcap']['install_path'], "ext", "nginx")
  notifies :restart, "service[nginx]"
end

nginx_site "router"

# nginx recipe adds a default site. It gets in our way, so we remove it.
nginx_site "default" do
  enable false
end

cloudfoundry_component "router" do
  install_path  node['cloudfoundry_router']['vcap']['install_path']
  ruby_version  ruby_ver
  pid_file      node['cloudfoundry_router']['pid_file']
  log_file      node['cloudfoundry_router']['log_file']
  action        [:create, :enable]
  subscribes    :restart, "cloudfoundry_source[router]"
end
