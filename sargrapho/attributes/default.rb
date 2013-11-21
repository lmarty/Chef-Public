#
# Cookbook Name:: sargrapho
# Attributes:: default
# Author:: Jason Cannon
#
 
default['sargrapho']['rpm']     = 'sargrapho-1.0.0-1.noarch.rpm'
default['sargrapho']['rpm_url'] = "https://github.com/jasonc/sargrapho/releases/download/v1.0.0/#{node['sargrapho']['rpm']}"
