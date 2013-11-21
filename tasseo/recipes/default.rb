#
# Author:: Dan Ryan <dan@crowdflower.com>
# Cookbook Name:: tasseo
# Recipe:: default
#
# Copyright 2012, CrowdFlower, Inc.
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

graphite_node = search(:node, 'recipes:graphite\:\:default').first

if node[:fqdn] != graphite_node[:fqdn]
  graphite_url = "https://#{graphite_node[:fqdn]}"
  node.set[:tasseo][:graphite_url] = graphite_url
end

include_recipe "runit"

git node[:tasseo][:home_dir] do
  repository node[:tasseo][:git_repo]
  reference "master"
  action :checkout
  notifies :restart, "service[tasseo]", :delayed
end

user node[:tasseo][:user] do
  comment "Tasseo User"
  system true
  shell "/bin/false"
end

directory node[:tasseo][:log_dir] do
  mode 0755
  owner node[:tasseo][:user]
  group node[:tasseo][:user]
end

package "ruby-dev"
package "build-essential"

gem_package "bundler"

execute "bundle install" do
  command "bundle install"
  cwd node[:tasseo][:home_dir]
end

runit_service "tasseo" do
  options node[:tasseo]
end
