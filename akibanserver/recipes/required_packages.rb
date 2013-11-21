#
# Cookbook Name:: akibanserver
# Recipe:: required_packages
#
# Copyright 2012, Akiban Technologies
#
# Apache License
#

# oracle java
node.override['java']['oracle']['accept_oracle_download_terms'] = true
node.override['java']['jdk_version'] = "7"
include_recipe "java::oracle"

# postgresql client 
include_recipe "postgresql::client"
