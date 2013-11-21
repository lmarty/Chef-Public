#
# Cookbook Name:: cloudfoundry-stager
# Attributes:: default
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

include_attribute "cloudfoundry::directories"

default['cloudfoundry_stager']['vcap']['install_path'] = "/srv/vcap-stager"
default['cloudfoundry_stager']['vcap']['repo']         = "https://github.com/cloudfoundry/stager.git"
default['cloudfoundry_stager']['vcap']['reference']    = "02c4448080426ab265f10a5ea4112e93ff2c4e6c"

default['cloudfoundry_stager']['log_level'] = "info"
default['cloudfoundry_stager']['log_file'] = File.join(node['cloudfoundry']['log_dir'], "stager.log")
default['cloudfoundry_stager']['pid_file'] = File.join(node['cloudfoundry']['pid_dir'], "stager.pid")

default['cloudfoundry_stager']['max_staging_duration'] = 120
default['cloudfoundry_stager']['max_active_tasks'] = 10
default['cloudfoundry_stager']['queues'] = ['staging']

default['cloudfoundry_stager']['data_dir'] = File.join(node['cloudfoundry']['data_dir'], "stager")
default['cloudfoundry_stager']['tmp_dir'] = File.join(node['cloudfoundry_stager']['data_dir'], "tmp")
default['cloudfoundry_stager']['cache_dir'] = File.join(node['cloudfoundry_stager']['data_dir'], "package_cache", "ruby")

# XXX unused?
default['cloudfoundry_stager']['secure'] = false
