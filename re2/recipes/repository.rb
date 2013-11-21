#
# Cookbook Name:: re2
# Recipe:: repository
#
# Copyright 2013, Jordi Llonch <llonchj@gmail.com>
#
# All rights reserved - Do Not Redistribute
#


include_recipe "mercurial"

mercurial "/tmp/re2" do
  repository node[:re2][:repository]
  #reference "tip"
  #key "/home/site/.ssh/keyname"
  owner "root"
  mode "0755"
  action :sync
  not_if { ::File.exists?(node[:re][:installed_lib]) }
end

execute "build re2" do
  command  "make install"
  cwd "/tmp/re2"
  not_if { ::File.exists?(node[:re][:installed_lib]) }
end
