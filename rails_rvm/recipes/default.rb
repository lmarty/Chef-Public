#
# Cookbook Name:: rails_rvm
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rails_user = node[:rails_rvm][:user]
rails_password = node[:rails_rvm][:password]
rails_uid = node[:rails_rvm][:uid]
rails_gid = node[:rails_rvm][:gid]
rvm_version = node[:rails_rvm][:rvm_version]
rails_version = node[:rails_rvm][:rails_version]

if rvm_version == "1.9.2"
  rvm_recipe = "ruby_192"
elsif rvm_version == "1.9.3"
  rvm_recipe = "ruby_193"
elsif rvm_version == "1.8.7"
  rvm_recipe = "ruby_187"
else
  rvm_recipe = "#{rvm_version}"
end

include_recipe "rvm::"+rvm_recipe

group rails_user do
  gid rails_gid
end

gem_package "ruby-shadow" do
  action :install
end

user rails_user do
  uid rails_uid
  gid rails_user
  supports :manage_home => true
  home "/home/"+rails_user
  shell "/bin/bash"
  password rails_password
end

bash "setup user "+rails_user+" for rvm" do
  user "root"
  ENV['RVM_USER'] = rails_user
  code <<-EOH
  sudo usermod -aG rvm $RVM_USER 
  EOH
end

bash "install rails version "+rails_version do
  user rails_user
  group "rvm"
  cwd "/home/"+rails_user
  ENV['RVM_VERSION'] = rvm_version
  ENV['RAILS_VERSION'] = rails_version
  code <<-EOH
  source /etc/profile.d/rvm.sh
  source /usr/local/rvm/scripts/rvm
  rvm --default use $RVM_VERSION
  gem install rails --version=$RAILS_VERSION
  EOH
end
