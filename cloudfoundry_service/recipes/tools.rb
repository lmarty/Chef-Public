#
# Cookbook Name:: cloudfoundry_service
# Recipe:: tools
#
# Copyright 2013, ZephirWorks
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

node.default['cloudfoundry_service']['tools']['install_path'] = ::File.join(node['cloudfoundry_service']['install_path'], 'tools')
install_path = node['cloudfoundry_service']['tools']['install_path']

# Set up our ruby
service_rbenv do
  namespace 'cloudfoundry_service'
  component 'tools'
end
ruby_ver = node['cloudfoundry_service']['tools']['ruby_version']

include_recipe "cloudfoundry_service::dependencies"

# Install all the tools
node['cloudfoundry_service']['tools']['install'].each do |tool_name|
  cloudfoundry_service_component tool_name.gsub('/', '_') do
    service_name  "tools/#{tool_name}"
    base_path     install_path
    ruby_version  ruby_ver
  end
end
