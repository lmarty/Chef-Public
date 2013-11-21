#
# Cookbook Name:: rdiff-backup
# Recipe:: client
#
# Copyright 2013, Piratenfraktion NRW
#

node.set['authorization']['sudo']['include_sudoers_d'] = true

include_recipe "rdiff-backup"

d = node['rdiff-backup']['etc_dir']
u = node['rdiff-backup']['user']
k = node['rdiff-backup']['key']

directory "#{d}/pre.d" do
  user u
  group u
end
directory "#{d}/post.d" do
  user u
  group u
end

cookbook_file "#{d}/.ssh/authorized_keys" do
  source "#{k}.pub"
  user u
  group u
  mode 0640
end

sudo "rdiff-backup" do
  user "rdiff-backup"
  runas "root"
  commands ["/usr/bin/rdiff-backup --server --restrict-read-only /"]
  nopasswd true
end

# include rdiff-backup stuff in backup
backup_path d
# include chef config in backup
backup_path "/etc/chef"
