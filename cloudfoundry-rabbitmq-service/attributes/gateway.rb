#
# Cookbook Name:: cloudfoundry-rabbitmq-service
# Attributes:: gateway
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

# Log level for the service gateway daemon.
default['cloudfoundry_rabbitmq_service']['gateway']['log_level'] = "info"

# Time out for talking to a service node.
default['cloudfoundry_rabbitmq_service']['gateway']['node_timeout'] = 30

# Time out for completing (de)provisioning requests.
default['cloudfoundry_rabbitmq_service']['gateway']['timeout'] = 15

# Human-readable aliases for RabbitMQ versions.
default['cloudfoundry_rabbitmq_service']['gateway']['version_aliases'] = {
  'current' => '2.4'
}

# The IP address of a host that will be used to determine the correct IP
# address to use to talk to other components.
default['cloudfoundry_rabbitmq_service']['gateway']['ip_route'] = nil

# Frequency in seconds between updating and announcing "varz" (i.e. service
# status information).
default['cloudfoundry_rabbitmq_service']['node']['z_interval'] = 30

# Interval in seconds between checks for orphan service instances; set to -1 to
# only check on request.
default['cloudfoundry_rabbitmq_service']['node']['check_orphan_interval'] = -1

# After a succesful first check for orphans, a second check will be run; this
# attribute determines the delay before this second check.
default['cloudfoundry_rabbitmq_service']['node']['double_check_orphan_interval'] = 300

# Maximum size in bytes of a single announcement; bigger ones will be split
# into multiple messages.
default['cloudfoundry_rabbitmq_service']['node']['max_nats_payload'] = 1048576
