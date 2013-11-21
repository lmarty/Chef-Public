#
# Cookbook Name:: cloudfoundry-mongodb-service
# Attributes:: gateway
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

# Log level for the service gateway daemon.
default['cloudfoundry_mongodb_service']['gateway']['log_level'] = "info"

# Time out for talking to a service node.
default['cloudfoundry_mongodb_service']['gateway']['node_timeout'] = 30

# Time out for completing (de)provisioning requests.
default['cloudfoundry_mongodb_service']['gateway']['timeout'] = 15

# Human-readable aliases for MongoDB versions.
default['cloudfoundry_mongodb_service']['gateway']['version_aliases'] = {
  'previous' => '1.8',
  'current' => '2.0',
  'next' => '2.2'
}

# Enable service lifecycle features.
default['cloudfoundry_mongodb_service']['gateway']['lifecycle']['enable'] = true

# Enable snapshots serialization.
default['cloudfoundry_mongodb_service']['gateway']['serialization']['enable'] = true

# Maximum number of snapshots that can be created.
default['cloudfoundry_mongodb_service']['gateway']['snapshot']['quota'] = 5
