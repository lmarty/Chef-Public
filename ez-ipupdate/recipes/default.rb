#
# Cookbook Name:: ez-ipupdate
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
#
#
package node['ez-ipupdate']['package_name']

template node['ez-ipupdate']['package_config'] do
    source    'default.conf.erb'
end
