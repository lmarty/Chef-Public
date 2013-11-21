#
# Cookbook Name:: netcfg
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "netcfg" do
  action [:install]
end

require 'resolv'
hostname = `hostname`.chomp
ip = Resolv.getaddress(hostname)

template "/etc/network.d/interfaces/eth0.conf" do
  source "eth0.conf.erb"
# Need to find out how to dynamically add IP Address for each host
  variables( :CONNECTION => "ethernet", :DESCRIPTION => "LAN", :INTERFACE => "eth0", :IP => "static", :ADDR => ip, :GATEWAY => "192.168.1.1")
end

service "network" do
  action [:enable,:start]
end
