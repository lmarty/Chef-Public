#
# Author:: Julian C. Dunn (<jdunn@opscode.com>)
# Cookbook Name:: tfchefint
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

default['tfchefint']['chefauth']['sf-admin-home'] = '/opt/collabnet/teamforge/var/home/sf-admin'
default['tfchefint']['chefauth']['chef-server-url'] = Chef::Config[:chef_server_url]

default['tfchefint']['artifact_update_hook']['app_bag_name'] = 'apps'
default['tfchefint']['artifact_update_hook']['target_env_field'] = 'Deploy To'
default['tfchefint']['artifact_update_hook']['frsid_field'] = 'FRSID'
default['tfchefint']['artifact_update_hook']['appname_field'] = 'Application Shortname'
