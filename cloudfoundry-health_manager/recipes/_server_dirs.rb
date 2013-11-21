#
# Cookbook Name:: cloudfoundry-health_manager
# Recipe:: _server_dirs
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

node.default['cloudfoundry_health_manager']['log_dir'] = node['cloudfoundry']['log_dir']
node.default['cloudfoundry_health_manager']['pid_dir'] = node['cloudfoundry']['pid_dir']
node.default['cloudfoundry_health_manager']['log_file'] = File.join(node['cloudfoundry_health_manager']['log_dir'], "health_manager.log")
node.default['cloudfoundry_health_manager']['pid_file'] = File.join(node['cloudfoundry_health_manager']['pid_dir'], "health_manager.pid")

%w[log_dir pid_dir].each do |d|
  directory node['cloudfoundry_health_manager'][d] do
    recursive true
    owner node['cloudfoundry']['user']
    group node['cloudfoundry']['group']
    mode  0755
  end
end
