#
# Cookbook Name:: sugar_crm
# Author::nagalakshmi.n@cloudenablers.com
# Recipe:: default
#
# Copyright 2013, Sugar_CRM
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


default[:sugar_crm][:db][:hostname] = 'localhost'
default[:sugar_crm][:db][:name] = 'sugarcrm'
default[:sugar_crm][:db][:user] = 'sugarcrm'
default[:sugar_crm][:dir] = 'sugarcrm'
default[:sugar_crm][:admin_pass] = 'admin'

set[:sugar_crm][:webroot] = "#{node[:apache][:docroot]}/#{node[:sugar_crm][:dir]}"

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

default[:sugar_crm][:db][:password] = secure_password
