#
# Cookbook Name:: multitail
# Recipe:: default
#
# Copyright 2013, DablWeb.com
#
# All rights reserved - Do Not Redistribute
#

package 'multitail'





template "#{node['multitail']['config_path']}/multitail.conf" do
  source 'multitail.conf.erb'
  mode 0444
  owner 'root'
  group 'root'
end