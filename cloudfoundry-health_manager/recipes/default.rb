#
# Cookbook Name:: cloudfoundry-health_manager
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

include_recipe "cloudfoundry-health_manager::_server_deps"
include_recipe "cloudfoundry-health_manager::_server_dirs"

cloudfoundry_source "health_manager" do
  path          node['cloudfoundry_health_manager']['install_path']
  repository    node['cloudfoundry_health_manager']['repo']
  reference     node['cloudfoundry_health_manager']['reference']
  ruby_version  node['cloudfoundry_health_manager']['ruby_version']
end

cloudfoundry_component "health_manager" do
  install_path  node['cloudfoundry_health_manager']['install_path']
  ruby_version  node['cloudfoundry_health_manager']['ruby_version']
  pid_file      node['cloudfoundry_health_manager']['pid_file']
  log_file      node['cloudfoundry_health_manager']['log_file']
  action        [:create, :enable]
  subscribes :restart, "cloudfoundry_source[health_manager]"
end
