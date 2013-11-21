#
# Cookbook Name:: atftp
# Recipe:: default
#
# Copyright 2011, Phatforge
#
# All rights reserved - Do Not Redistribute
#

package "atftpd" do
  action :install
end

service "atftpd" do
  supports :restart => true
  action [:enable, :start]
end

directory "/srv/tftp" do
  action :create
  owner "nobody"
  group "root"
  mode  "777"
end

atftpd_inetd

template "/etc/default/atftpd" do
  source "atftpd.erb"
  notifies :restart, resources(:service => "atftpd")
end



