#
# Cookbook Name:: cloudfoundry-rabbitmq-service
# Attributes:: install
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

default['cloudfoundry_rabbitmq_service']['version'] = "2.4.1"
default['cloudfoundry_rabbitmq_service']['version_full'] = "generic-unix-2.4.1"
default['cloudfoundry_rabbitmq_service']['path'] = File.join("", "srv", "rabbitmq", "rabbitmq-#{node['cloudfoundry_rabbitmq_service']['version']}")
default['cloudfoundry_rabbitmq_service']['source'] = "http://www.rabbitmq.com/releases/rabbitmq-server/v#{node['cloudfoundry_rabbitmq_service']['version']}/rabbitmq-server-#{node['cloudfoundry_rabbitmq_service']['version_full']}.tar.gz"
default['cloudfoundry_rabbitmq_service']['plugins'] = ["amqp_client", "mochiweb", "rabbitmq-management", "rabbitmq-management-agent", "rabbitmq-mochiweb", "webmachine"]
default['cloudfoundry_rabbitmq_service']['plugins_source'] = "http://www.rabbitmq.com/releases/plugins/v#{node['cloudfoundry_rabbitmq_service']['version']}/"
