#
# Cookbook Name:: cloudfoundry-rabbitmq-service
# Attributes:: node
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

# Log level for the service node daemon.
default['cloudfoundry_rabbitmq_service']['node']['log_level'] = "info"

# Unique instance info; should be configured to be different between nodes.
default['cloudfoundry_rabbitmq_service']['node']['index'] = 0

# Maximum number of service instances for this node.
default['cloudfoundry_rabbitmq_service']['node']['capacity'] = 200

# The lower end of a range of ports that can be used for services nodes.
default['cloudfoundry_rabbitmq_service']['node']['port_range']['first'] = 10001

# The higher end of a range of ports that can be used for services nodes.
default['cloudfoundry_rabbitmq_service']['node']['port_range']['last'] = 20000

# The lower end of a range of ports that can be used for the admin interface
# of services nodes.
default['cloudfoundry_rabbitmq_service']['node']['admin_port_range']['first'] = 20001

# The higher end of a range of ports that can be used for the admin interface
# of services nodes.
default['cloudfoundry_rabbitmq_service']['node']['admin_port_range']['last'] = 30000

# Path to a directory that will be used when dumping and reimporting a node.
default['cloudfoundry_rabbitmq_service']['node']['migration_nfs'] = "/mnt/migration"

# Maximum number of clients that can connect to the service.
default['cloudfoundry_rabbitmq_service']['node']['max_clients'] = 1000

# A Hash mapping versions of RabbitMQ to their runtime details.
default['cloudfoundry_rabbitmq_service']['node']['versions'] = {}

# The default version for requests to this node.
default['cloudfoundry_rabbitmq_service']['node']['default_version'] = "2.4"

# Maximum percentage of memory to use.
default['cloudfoundry_rabbitmq_service']['node']['max_memory_factor'] = 0.5

# The IP address of a host that will be used to determine the correct IP
# address to use to talk to other components.
default['cloudfoundry_rabbitmq_service']['node']['ip_route'] = nil

# Frequency in seconds between updating and announcing "varz" (i.e. service
# status information).
default['cloudfoundry_rabbitmq_service']['node']['z_interval'] = 30

# Maximum size in bytes of a single announcement; bigger ones will be split
# into multiple messages.
default['cloudfoundry_rabbitmq_service']['node']['max_nats_payload'] = 1048576

# If true, service bindings credentials will be issued using the hostname.
# If false, the IP address will be used instead.
default['cloudfoundry_rabbitmq_service']['node']['fqdn_hosts'] = false

# Maximum time to wait during provisioning.
default['cloudfoundry_rabbitmq_service']['node']['op_time_limit'] = 8
