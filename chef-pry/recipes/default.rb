#
# Cookbook Name:: chef-pry
# Recipe:: default
#

node.set['build_essential']['compiletime'] = true

include_recipe 'build-essential::default'

node['chef-pry']['dependencies'].each do |pkg|
  package pkg
end

%w{pry pry-debugger}.each do |gem|
  chef_gem gem
end
