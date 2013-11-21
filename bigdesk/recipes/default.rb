#
# Author:: Sebastian Wendel
# Cookbook Name:: bigdesk
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

unless FileTest.exists?(node[:bigdesk][:install_path])
  remote_file "bigdesk" do
    path "/tmp/bigdesk.tar.gz"
    source "#{node[:bigdesk][:src_mirror]}"
  end

  bash "untar-bigdesk" do
    code "(cd /tmp; tar zxvf /tmp/bigdesk.tar.gz; rm -f /tmp/bigdesk.tar.gz)"
  end

  bash "install-bigdesk" do
    code "mv /tmp/lukas-vlcek-bigdesk-* #{node[:bigdesk][:install_path]}"
  end

  directory "#{node[:bigdesk][:install_path]}" do
    recursive true
    owner "#{node[:bigdesk][:run_user]}"
    group "#{node[:bigdesk][:run_group]}"
    mode 0755
  end

  log "Navigate to 'http://#{node[:fqdn]}/bigdesk' to use bigdesk." do
    action :nothing
  end
end
