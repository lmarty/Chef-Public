#
# Cookbook Name:: teamforge
# Recipe:: cli
#
# Copyright 2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'rhel'
  remote_file "#{Chef::Config[:file_cache_path]}/teamforge_cli.rpm" do
    source node['teamforge']['cli']['url']
    checksum node['teamforge']['cli']['checksum']
  end

  package "teamforge_cli" do
    source "#{Chef::Config[:file_cache_path]}/teamforge_cli.rpm"
    action :install
  end

when 'mac_os_x'
  dmg_package "ctf" do
    source node['teamforge']['cli']['url']
    volumes_dir "TeamForge CLI"
    dmg_name "TeamForge-CLI-1.5.0.0-1665.dmg"
    action :install
  end

end

template "#{ENV['HOME']}/.ctf_cli" do
  source "dot-ctf_cli.erb"
  mode 00644
  action :create
end
