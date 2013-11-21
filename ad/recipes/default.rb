# Cookbook Name:: ad
# Recipe:: default
# Author:: Bryan McLellan <btm@loftninjas.org>
#
# Copyright 2010, Opscode, Inc
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

begin
  ad = Chef::DataBagItem.load(:ad, :main)
rescue
  Chef::Log.fatal("Could not find the 'main' item in the 'ad' data bag")
  raise
end

# Install the 'role' for Active Directory
#   This is a pre-flight step that installs the software but doesn't configure AD
#   This is an idempotent step, but returns 1003 (235?) if already installed.
execute "install_ad" do
  command "servermanagercmd -install ADDS-Domain-Controller"
  returns 0
  returns 235
end

dcpromo_answer="C:/windows/temp/dcpromo_unattend.txt"

template dcpromo_answer do
  source "dcpromo.txt.erb"
  variables(
    :type => ad['type'] ? ad['type'] : "forest",
    :domain_name => ad['domain_name'],
    :netbios_name => ad['netbios_name'] ? ad['netbios_name'] : false,
    :site_name => ad['site_name'] ? ad['site_name'] : false,
    :child_name => ad['child_name'] ? ad['child_name'] : false,
    :user_name => ad['user_name'] ? ad['user_name'] : false,
    :user_domain => ad['user_domain'] ? ad['user_domain'] : false,
    :user_password => ad['user_password'] ? ad['user_password'] : false,
    :dns_user_name => ad['dns_user_name'] ? ad['dns_user_name'] : false,
    :dns_user_password => ad['dns_user_password'] ? ad['dns_user_password'] : false,
    :admin_password => ad['admin_password']
  )
end

execute "dcpromo /unattend:#{dcpromo_answer}" 
