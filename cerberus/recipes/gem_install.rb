#
# Cookbook Name:: cerberus
# Recipe:: gem_install
#
# Author:: Steven Craig <support@smashrun.com>
# Copyright 2013, Smashrun, Inc.
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

log("begin gem_install") { level :debug }
log("running gem_install") { level :info }

["#{node[:firewall][:tempdir]}", "#{node['firewall']['jsonconf']}"].each do |dir|
  directory "#{dir}" do
    action :create
    not_if { File.exists?("#{dir}") }
    recursive true
  end
end

# this does not work properly on 2003, however, it does on 2008
node['firewall']['gem'].each do |g|
  r = gem_package("#{g[:name]}") do
    action :nothing
    version "#{g[:version]}"
  end
  r.run_action(:install)
  Gem.clear_paths
end

if node['chef_packages']['chef']['version'] >= "0.10.9"
  node['firewall']['gem'].each do |g|
    chef_gem("#{g[:name]}") do
      action :install
      version "#{g[:version]}"
    end
  end
end

log("end gem_install") { level :info }
