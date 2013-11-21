#
# Cookbook Name:: cloudfoundry-stager
# Recipe:: default
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

node.default['cloudfoundry_stager']['ruby_version'] = node['cloudfoundry']['ruby_version']

include_recipe "cloudfoundry-stager::runtimes"

ruby_ver = node['cloudfoundry_stager']['ruby_version']
ruby_path = ruby_bin_path(ruby_ver)

%w[curl libxml2 libxml2-dev libxslt1-dev].each do |pkg|
  package pkg
end

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby ruby_ver

%w[data_dir tmp_dir cache_dir].each do |d|
  directory node['cloudfoundry_stager'][d] do
    owner node['cloudfoundry']['user']
    group node['cloudfoundry']['group']
    mode 0755
    recursive true
  end
end

directory node['cloudfoundry']['config_dir'] do
  owner node['cloudfoundry']['user']
  group node['cloudfoundry']['group']
  mode 0755
end

template File.join(node['cloudfoundry']['config_dir'], "platform.yml") do
  source "platform.yml.erb"
  owner node['cloudfoundry']['user']
  group node['cloudfoundry']['group']
  mode 0644
end

cloudfoundry_source "stager" do
  path          node['cloudfoundry_stager']['vcap']['install_path']
  repository    node['cloudfoundry_stager']['vcap']['repo']
  reference     node['cloudfoundry_stager']['vcap']['reference']
  ruby_version  ruby_ver
end

cloudfoundry_component "stager" do
  install_path  node['cloudfoundry_stager']['vcap']['install_path']
  ruby_version  ruby_ver
  pid_file      node['cloudfoundry_stager']['pid_file']
  log_file      node['cloudfoundry_stager']['log_file']
  upstart_file_cookbook "cloudfoundry-stager"
  action        [:create, :enable, :start]
  subscribes    :restart, "cloudfoundry_source[stager]"
end
