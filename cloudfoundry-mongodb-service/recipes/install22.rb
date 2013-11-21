#
# Cookbook Name:: cloudfoundry-mongodb-service
# Recipe:: install20
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

node.set['cloudfoundry_mongodb_service']['node']['versions']['2.2'] = {}
mongo20cfg = node['cloudfoundry_mongodb_service']['node']['versions']['2.2']
mongo20cfg['mongod_base_path'] = "/usr"
mongo20cfg['mongod_options'] = ""

include_recipe "mongodb::10gen_repo"

service "mongodb" do
  action [:stop, :disable]
  only_if { ::File.exists?("/etc/init.d/mongodb") }
end

file "/etc/init.d/mongodb" do
  action :delete
end
