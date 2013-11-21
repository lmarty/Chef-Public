#
# Cookbook Name:: ldap
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node.default['openldap-server'][:domain_suffix] = node['openldap-server'][:domain].split('.').collect {|n| "dc=#{n}"}.join(',')
node.default['openldap-server'][:rootDN] = "#{node['openldap-server'][:root_user_attr]},#{node['openldap-server'][:domain_suffix]}"

include_recipe 'openldap-server::install'
include_recipe 'openldap-server::createdb'

service 'slapd' do
  action [:start]
end

