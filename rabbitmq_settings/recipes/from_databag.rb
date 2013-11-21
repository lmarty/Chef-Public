#
# Cookbook Name:: rabbitmq_settings
# Recipe:: from_databag
#
# Copyright (C) 2013 HiganWorks LLC
# Author:: Yukihiko Sawanobori<sawanoboriyu@higanworks.com>
# 
# LICENSE: MIT
#

include_recipe "rabbitmq::default"

bag_vhosts = data_bag_item(node['rabbitmq_settings']['databag_name'],'vhosts')

bag_vhosts['vhosts'].each_pair do |vhostname, action_kind|
  rabbitmq_vhost vhostname do
    action action_kind.to_sym
  end
end

bag_users = data_bag_item(node['rabbitmq_settings']['databag_name'],'users')


bag_users['users'].each_pair do |username, attributes|
  rabbitmq_user username do
    action attributes['action'].to_sym
    password attributes['password']
  end

  ## set or clear permission
  if attributes['action'] == "add" and attributes.has_key?("permissions") then
    attributes["permissions"].each_pair do |vhostname, permission_set|
      rabbitmq_user username do
        vhost vhostname
        unless permission_set == nil then
          permissions permission_set
          action :set_permissions
        else
          action :clear_permissions
        end
      end
    end
  end
end
