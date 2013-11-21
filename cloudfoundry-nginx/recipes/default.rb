#
# Cookbook Name:: cloudfoundry-nginx
# Recipe:: default
#
# Copyright 2012, ZephirWorks
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

dist_name = node['platform_version'].to_f < 12.04 ? "lucid" : "precise"

apt_repository "nginx" do
  uri "http://ppa.launchpad.net/nginx/stable/ubuntu"
  distribution dist_name
  components ["main"]
  keyserver "hkp://keyserver.ubuntu.com:80"
  key "C300EE8C"
  notifies :run, "execute[apt-get-update-nginx]", :immediately
end

execute "apt-get-update-nginx" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end

node.default['nginx']['default_site_enabled'] = false
include_recipe "nginx"

r = resources('package[nginx]')
r.instance_eval do
  package_name 'nginx-extras'
end

r = resources('template[nginx.conf]')
r.instance_eval do
  cookbook "cloudfoundry-nginx"
end
