#
# Cookbook Name:: zotonic
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "zotonic::requirements"
include_recipe "zotonic::#{node["zotonic"]["install_method"]}"
