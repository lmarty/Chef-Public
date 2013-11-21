#
# Author:: Seth Vargo
# Cookbook Name:: chef-zero
# Attribute:: default
#
# Copyright 2013, Seth Vargo <sethvargo@gmail.com>
# Copyright 2013, Opscode, Inc.
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

# The version of the Chef Zero gem to install
default['chef-zero']['version'] = '1.5.1'

# Whether to install/start the Chef Zero gem (since it was packaged in Chef)
default['chef-zero']['install'] = false
default['chef-zero']['start']   = false

# The name of the daemon (/etc/init.d/#{name})
default['chef-zero']['daemon'] = 'chef-zero'

# The IP Address or hostname to listen on
default['chef-zero']['host'] = '0.0.0.0'

# The port or socket to listen on
default['chef-zero']['listen'] = '80'

# Set to true if the server should generate real keys
default['chef-zero']['generate_real_keys'] = false
