#
# Cookbook Name:: rbenv-gemset
# Recipe:: default
#
# Copyright (C) 2013 José P. Airosa
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'git'
include_recipe 'rbenv'

plugin_path = "#{node[:rbenv][:root]}/plugins/rbenv-gemset"

git plugin_path do
  repository node[:rbenv_gemset][:git_repository]
  reference  node[:rbenv_gemset][:git_revision]
  user node[:rbenv][:user]
  group node[:rbenv][:group]
  action :sync
end