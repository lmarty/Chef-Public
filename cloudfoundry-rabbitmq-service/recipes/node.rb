#
# Cookbook Name:: cloudfoundry-rabbitmq-service
# Recipe:: node
#
# Copyright 2012-2013, ZephirWorks
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

node.default['cloudfoundry_rabbitmq_service']['node']['base_dir'] = File.join(node['cloudfoundry_service']['base_dir'], "rabbit")
node.default['cloudfoundry_rabbitmq_service']['node']['db_logs_dir'] = File.join(node['cloudfoundry']['log_dir'], "rabbit")
node.default['cloudfoundry_rabbitmq_service']['node']['instances_dir'] = "#{node['cloudfoundry_rabbitmq_service']['node']['base_dir']}/instances"

include_recipe "cloudfoundry-rabbitmq-service::install"

service_rbenv do
  namespace 'cloudfoundry_rabbitmq_service'
  component 'node'
end

include_recipe "cloudfoundry_service::dependencies"

%w(base_dir db_logs_dir instances_dir).each do |dir|
  directory node['cloudfoundry_rabbitmq_service']['node'][dir] do
    owner node['cloudfoundry']['user']
    group node['cloudfoundry']['group']
    mode  "0755"
    recursive true
  end
end

cloudfoundry_service_component "rabbit_node" do
  service_name  "rabbit"
  ruby_version  node['cloudfoundry_rabbitmq_service']['node']['ruby_version']
  action        [:create, :enable]
end
