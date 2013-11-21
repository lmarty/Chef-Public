#
# Cookbook Name:: powerdns
# Recipe:: default
#
# Copyright 2009, Adapp, Inc.
#

group "pdns" do
  gid 53
end

user "pdns" do
  comment "powerdns user"
  gid "pdns"
  uid 53
  home "/var/empty"
  supports :manage_home => false
  shell "/sbin/nologin"
end


