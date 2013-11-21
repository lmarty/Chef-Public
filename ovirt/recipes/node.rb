#
# Cookbook Name:: ovirt
# Recipe:: node
# Author:: Jason Cannon
#

include_recipe 'ovirt'

return unless node['ovirt']['supported_platforms'].include?(node['platform'])

package 'vdsm' do
  action :install
end

service 'vdsmd' do
  action [ :enable, :start ]
end
