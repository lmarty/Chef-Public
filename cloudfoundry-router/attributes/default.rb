#
# Cookbook Name:: cloudfoundry-router
# Attributes:: default
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

include_attribute "cloudfoundry"

default['cloudfoundry_router']['vcap']['install_path'] = "/srv/vcap-router"
default['cloudfoundry_router']['vcap']['repo']         = "https://github.com/cloudfoundry/router.git"
default['cloudfoundry_router']['vcap']['reference']    = "346867cfa72a7d0e9d8f80fa4cfa95261834c260"

default['cloudfoundry_router']['listen_ip'] = "0.0.0.0"
default['cloudfoundry_router']['listen_port'] = "80"
default['cloudfoundry_router']['socket_file'] = "/tmp/router.sock"
default['cloudfoundry_router']['access_log'] = File.join(node['cloudfoundry']['log_dir'], "vcap.access.log")
default['cloudfoundry_router']['client_max_body_size'] = "256M"

default['cloudfoundry_router']['log_level'] = "info"
default['cloudfoundry_router']['log_file'] = File.join(node['cloudfoundry']['log_dir'], "router.log")
default['cloudfoundry_router']['pid_file'] = File.join(node['cloudfoundry']['pid_dir'], "router.pid")
