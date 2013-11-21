#
# Cookbook Name:: perceptive_content_bridge
# Attributes:: default
#
# Copyright 2013, Perceptive Software

include_attribute "perceptive_user_management"
node.default[:perceptive_user_management][:data_bag_name] = "users-contentBridge"

