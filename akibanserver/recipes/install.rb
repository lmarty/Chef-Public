#
# Cookbook Name:: akibanserver
# Recipe:: install
#
# Copyright 2012, Akiban Technologies
#
# Apache License
#

package "akiban-server" do
  action :install
end

service "akiban-server" do
  supports :status => true, :restart => true
end
