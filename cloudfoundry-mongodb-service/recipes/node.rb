#
# Cookbook Name:: cloudfoundry-mongodb-service
# Recipe:: node
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

# Default attributes
node.default['cloudfoundry_mongodb_service']['node']['base_dir'] = File.join(node['cloudfoundry_service']['base_dir'], "mongodb")
node.default['cloudfoundry_mongodb_service']['node']['db_logs_dir'] = File.join(node['cloudfoundry']['log_dir'], "mongodb")
node.default['cloudfoundry_mongodb_service']['node']['instances_dir'] = "#{node['cloudfoundry_mongodb_service']['node']['base_dir']}/instances"

# Pre-computed a few variables
base_dir = ::File.join(node['cloudfoundry_service']['install_path'], "mongodb_node")
bin_dir = ::File.join(base_dir, "mongodb", "bin")
config_file = ::File.join(node['cloudfoundry']['config_dir'], "mongodb_backup.yml")

# Set up our ruby
service_rbenv do
  namespace 'cloudfoundry_mongodb_service'
  component 'node'
end
ruby_ver = node['cloudfoundry_mongodb_service']['node']['ruby_version']
ruby_path = ruby_bin_path(ruby_ver)

# Set up common service dependencies
include_recipe "cloudfoundry_service::dependencies"

#
# Service node
#
cloudfoundry_service_component "mongodb_node" do
  base_path     base_dir
  service_name  "mongodb"
  ruby_version  ruby_ver
  action        [:create, :enable]
end

%w[base_dir db_logs_dir instances_dir].each do |d|
  directory node['cloudfoundry_mongodb_service']['node'][d] do
    owner node['cloudfoundry']['user']
    group node['cloudfoundry']['group']
    mode  "0755"
  end
end

#
# Service worker
#
cloudfoundry_service_component "mongodb_worker" do
  base_path     base_dir
  service_name  "mongodb"
  ruby_version  ruby_ver
  action        [:create, :enable]
end

#
# Service backup
#
template config_file do
  source "mongodb_backup-config.yml.erb"
  owner   node['cloudfoundry']['user']
  group   node['cloudfoundry']['group']
  mode    0644
  variables(
    :pid_file       => "#{node['cloudfoundry']['pid_dir']}/mongodb_backup.pid",
    :log_file       => "#{node['cloudfoundry']['log_dir']}/mongodb_backup.log"
  )
end

cron "mongodb_backup" do
  hour "03"
  minute "2"
  command "#{bin_dir}/mongodb_backup -c #{config_file}"
  path "#{ruby_path}:/usr/local/bin:/usr/bin:/bin"
  user node['cloudfoundry']['user']
end
