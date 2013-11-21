#
# Cookbook Name:: mogilefs
# Recipe:: default
#
# Author:: Jamie Winsor (<jamie@enmasse.com>)
#
# Copyright 2011, En Masse Entertainment, Inc.
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

include_recipe "perl"

cpan_module "YAML"
cpan_module "MogileFS::Server"
cpan_module "MogileFS::Client"
cpan_module "MogileFS::Utils"

# Install mogeilfs-client gem for use later: 
# http://wiki.opscode.com/display/chef/Evaluate+and+Run+Resources+at+Compile+Time
g = gem_package "mogilefs-client" do
  action :nothing
end

g.run_action(:install)

Gem.clear_paths
require 'mogilefs'

user node[:mogilefs][:user] do
  comment "MogileFS unprivileged user"
  shell "/bin/false"
  system true
end

directory node[:mogilefs][:dir] do
  owner "root"
  group "root"
  mode 0755
  recursive true
end
