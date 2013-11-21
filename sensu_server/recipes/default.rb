#
# Cookbook Name:: sensu_server
# Recipe:: default
#

include_recipe "sensu::rabbitmq"
include_recipe "sensu::redis"

include_recipe 'sensu::default'

include_recipe "sensu::server_service"
include_recipe "sensu::api_service"
include_recipe "sensu::dashboard_service"
