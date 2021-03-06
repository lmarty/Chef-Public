#
# Cookbook Name:: ca_openldap
# Recipe File:: populate
#
# Copyright 2013, Christophe Arguel <christophe.arguel@free.fr>
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

chef_gem 'net-ldap'
chef_gem 'activeldap'

class Chef::Recipe
    include CAOpenldap
end

lu = LDAPUtils.new(node.ca_openldap.ldap_server, 
                   node.ca_openldap.ldap_port, 
                   build_rootdn(), 
                   node.ca_openldap.rootpassword)

parse_populate_data_bag_item do |dn, attrs|
  ruby_block "add_entry_#{dn}" do
    block do

      # hash the password if needed
      password = attrs['userPassword']
      if (password && ! password.match(/\{(?:S?SHA|MD5)\}/))
        attrs["userPassword"] = LDAPUtils.ssha_password password
      end

      Chef::Log.info "add entry dn=#{dn}, attrs=#{attrs}"
      lu.add_entry(dn, attrs)
    end
  end
end
