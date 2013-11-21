#
# Cookbook Name:: rdiff-backup
# Recipe:: default
#
# Copyright 2013, Piratenfraktion NRW
#

package "rdiff-backup"

d = node['rdiff-backup']['etc_dir']
u = node['rdiff-backup']['user']

user u do
  comment "rdiff-backup service user"
  home d
end

directory "#{d}" do
  user u
  group u
end

directory "#{d}/.ssh" do
  user u
  group u
  mode 0750
end
