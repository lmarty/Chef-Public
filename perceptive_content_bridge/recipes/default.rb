#
# Cookbook Name:: perceptive_content_bridge
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "perceptive_user_management::manage_users"
include_recipe "perceptive_user_management::manage_root"
include_recipe "perceptive_user_management::authorized_keys"
include_recipe "perceptive_bash::user"
include_recipe "perceptive_ssh"