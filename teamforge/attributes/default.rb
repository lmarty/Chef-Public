#
# Author:: Julian C. Dunn (<jdunn@opscode.com>)
# Cookbook Name:: teamforge
# Attributes:: default
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

default['teamforge']['server']['public_site_name'] = node['fqdn']
default['teamforge']['server']['local_features'] = %w{app database cvs subversion}
default['teamforge']['server']['version'] = '6.2.0.1'
default['teamforge']['server']['install_dir'] = "/opt/collabnet/teamforge-installer/#{node['teamforge']['server']['version']}"
default['teamforge']['server']['scm_default_shared_secret'] = nil
default['teamforge']['server']['listen_ports'] = [ '80' ]

default['teamforge']['codesight']['public_site_name'] = node['fqdn']
default['teamforge']['codesight']['ssl'] = false

case node['platform_family']
when 'rhel'
  default['teamforge']['cli']['frsid'] = node['kernel']['machine'] == 'x86_64' ? 'frs8161' : 'frs8162'
  default['teamforge']['cli']['checksum'] = node['kernel']['machine'] == 'x86_64' ? 'fde8b5d74caf05b0460f42a7d8820d37' : '928a387c49f89eb1437baee28cb86beb'
when 'mac_os_x'
  default['teamforge']['cli']['frsid'] = 'frs8159'
  default['teamforge']['cli']['checksum'] = nil
end

default['teamforge']['cli']['url'] = "https://ctf.open.collab.net/sf/frs/do/downloadFile/projects.labs/frs.teamforge_cli.teamforge_cli_version_1_5_0_0/#{node['teamforge']['cli']['frsid']}?dl=1"

default['teamforge']['cli']['api_url'] = "http://#{node['teamforge']['server']['public_site_name']}"
default['teamforge']['cli']['api_alias'] = 'tf'
default['teamforge']['cli']['prog'] = '/opt/collabnet/teamforge/add-ons/teamforge_cli/bin/ctf'

default['teamforge']['cli']['api_user'] = 'admin'
default['teamforge']['cli']['api_password'] = 'ZGZ2ZmNmZGLlZGcOLzAxZGVmAN=='
