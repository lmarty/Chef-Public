#
# Cookbook Name:: sargrapho
# Recipe:: default
# Author:: Jason Cannon
#

package 'rrdtool' do
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['sargrapho']['rpm']}" do
  source node['sargrapho']['rpm_url']
  not_if 'rpm -q sargrapho'
  notifies :install, "rpm_package[#{node['sargrapho']['rpm']}]", :immediately
end

rpm_package node['sargrapho']['rpm'] do
  source "#{Chef::Config[:file_cache_path]}/#{node['sargrapho']['rpm']}"
  only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/#{node['sargrapho']['rpm']}")}
  action :install
end
