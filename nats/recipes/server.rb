#
# Cookbook Name:: nats
# Recipe:: server
#
# Copyright 2012, ZephirWorks
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

node.default['nats_server']['pid_file']   = File.join(node['cloudfoundry']['pid_dir'], "nats-server.pid")
node.default['nats_server']['log_file']   = File.join(node['cloudfoundry']['log_dir'], "nats-server.log")

node.default['nats_server']['ruby_version'] = node['cloudfoundry']['ruby_version']
ruby_ver = node['nats_server']['ruby_version']
ruby_path = ruby_bin_path(ruby_ver)

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby ruby_ver

rbenv_gem "nats" do
  ruby_version ruby_ver
  version node['nats']['gem']['version']
end

cloudfoundry_component "nats-server" do
  component_name  "nats-server"
  ruby_version    ruby_ver
  pid_file        node['nats_server']['pid_file']
  log_file        node['nats_server']['log_file']
  bin_file        File.join(ruby_path, "nats-server")
  action          [:create, :enable]
end
