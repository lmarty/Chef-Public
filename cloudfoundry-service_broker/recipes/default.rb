#
# Cookbook Name:: cloudfoundry_service_broker
# Recipe:: default
#
# Copyright 2012, ZephirWorks
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

node.default['cloudfoundry_service_broker']['base_dir'] = File.join(node['cloudfoundry_service']['base_dir'], "service_broker")

service_rbenv do
  namespace 'cloudfoundry_service_broker'
  component 'default' # XXX
end

include_recipe "cloudfoundry_service::dependencies"

cloudfoundry_service_component "service_broker" do
  service_name  "service_broker"
  ruby_version  node['cloudfoundry_service_broker']['default']['ruby_version']
  extra_args    "-p #{node['cloudfoundry']['config_dir']}/service_broker-pre_defined_services.yml"
  action        [:create, :enable]
end

template "#{node['cloudfoundry']['config_dir']}/service_broker-pre_defined_services.yml" do
  source   "pre_defined_services.yml.erb"
  owner    node['cloudfoundry']['user']
  mode     "0644"
end
