#
# Cookbook Name:: minecraft
# Recipe:: mark2
#
# Copyright 2013, Greg Fitzgerald
# Copyright 2013, Sean Escriva
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'python'

python_pip 'mark2'

directory '/etc/mark2' do
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0755
end

file '/etc/mark2/mark2.properties' do
  content '# custom settings go in server specific mark2.properties file'
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  action :create_if_missing
end

template "#{node['minecraft']['install_dir']}/mark2.properties" do
  source 'mark2.properties.erb'
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  notifies :reload, 'service[minecraft]', :immediately
end
