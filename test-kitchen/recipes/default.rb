#
# Cookbook Name:: test-kitchen
# Recipe:: default
#
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


include_recipe "build-essential"

['libxml2-dev','libxml2','libxslt-dev'].each do |pkg|
  p = package pkg
  p.run_action(:install)
end

execute "vagrant plugin install vagrant-berkshelf" do
  environment ({'HOME' => "/home/#{node['test-kitchen']['user']}"})
  user node['test-kitchen']['user']
end

chef_gem "berkshelf"

chef_gem "test-kitchen" do
  options(:prerelease => true)
  version node['test-kitchen']['version']
end

chef_gem "kitchen-vagrant"
