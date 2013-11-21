#
# Author:: Sebastian Wendel
# Cookbook Name:: elasticsearch-head
# Recipe:: default
#
# Copyright 2012, SourceIndex IT-Services
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

include_recipe "elasticsearch"
include_recipe "apache2"

unless FileTest.exists?(node[:elastichead][:install_path])
  remote_file "elastichead" do
    path "/tmp/elastichead.tar.gz"
    source "#{node[:elastichead][:src_mirror]}"
  end

  bash "untar-elastichead" do
    code "(cd /tmp; tar zxvf /tmp/elastichead.tar.gz; rm -f /tmp/elastichead.tar.gz)"
  end

  bash "install-elastichead" do
    code "mv /tmp/mobz-elasticsearch-* #{node[:elastichead][:install_path]}"
  end

  directory "#{node[:elastichead][:install_path]}" do
    recursive true
    owner "#{node[:elastichead][:run_user]}"
    group "#{node[:elastichead][:run_group]}"
    mode 0755
  end

  log "Navigate to 'http://#{node[:fqdn]}/elastichead' to use elasticsearch-head." do
    action :nothing
  end
end
