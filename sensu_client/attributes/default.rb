#
# Cookbook Name:: sensu_client
# Attributes:: default
#

default[:sensu_client][:additional_attributes] = Mash.new
default[:sensu_client][:sensu_plugin_version] = false

default[:sensu_client][:subscriptions] = ['all'] + node[:roles]
