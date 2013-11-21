#
# Cookbook Name:: ovirt
# Recipe:: default
# Author:: Jason Cannon
#

unless node['ovirt']['supported_platforms'].include?(node['platform'])
  Chef::Log.error("#{node['platform']} operating system is not supported by the #{cookbook_name} cookbook.")
  return
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['ovirt']['ovirt_release_rpm']}" do
  source node['ovirt']['ovirt_release_rpm_url']
  not_if 'rpm -qa | grep ovirt-release'
  notifies :install, "rpm_package[#{node['ovirt']['ovirt_release_rpm']}]", :immediately
end

rpm_package node['ovirt']['ovirt_release_rpm'] do
  source "#{Chef::Config[:file_cache_path]}/#{node['ovirt']['ovirt_release_rpm']}"
  only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/#{node['ovirt']['ovirt_release_rpm']}")}
  action :install
end
