#
# Cookbook Name:: tfchefint
# Recipe:: sudoers
# Author:: Julian C. Dunn (<jdunn@opscode.com>)
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

chefclient = (!node['chef_client'].nil? && !node['chef_client']['bin'].nil?) ? node['chef_client']['bin'] : '/usr/bin/chef-client'

sudo 'sf-admin' do
  user      'sf-admin'
  runas     'root'
  commands  [ "#{chefclient} --once", '/usr/bin/pkill -USR1 chef-client' ]
  nopasswd  true
end