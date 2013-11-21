#
# Cookbook Name:: rdiff-backup
# Recipe:: server
#
# Copyright 2013, Piratenfraktion NRW
#

include_recipe "rdiff-backup::client"
include_recipe "ssh_known_hosts"

d = node['rdiff-backup']['etc_dir']
u = node['rdiff-backup']['user']
k = node['rdiff-backup']['key']

directory d do
  user u
  group u
end
directory "#{d}/ondemand" do
  user u
  group u
end

directory node['rdiff-backup']['backup_dir'] do
  user u
  group u
end

cookbook_file "#{d}/.ssh/id_rsa" do
  source k
  user u
  group u
  mode 0600
end

clients = partial_search(:node, "rdiff-backup:[* TO *]",
			:keys => {
			'fqdn' => [ 'fqdn' ],
			'dirs' => [ 'rdiff-backup', 'include' ]
})

clients.sort_by! do |c|
  c['fqdn']
end

clients.each do |c|
  ssh_known_hosts_entry c['fqdn']

  # create ondemand backup script
  if c['dirs'] != nil then
    template "#{d}/ondemand/#{c['fqdn']}.sh" do
      source "ondemand.sh.erb"
      user u
      group u
      mode 0750
      variables ({
	:c => c
      })
    end
  end
end

template "#{d}/backup.sh" do
  source "backup.sh.erb"
  user u
  group u
  mode 0750
  variables ({
    :clients => clients
  })
end

if node['rdiff-backup']['cron']['enable'] then
  cron "backup" do
    day node['rdiff-backup']['cron']['day']
    hour node['rdiff-backup']['cron']['hour']
    minute node['rdiff-backup']['cron']['minute']
    month node['rdiff-backup']['cron']['month']
    weekday node['rdiff-backup']['cron']['weekday']
    if node['rdiff-backup']['cron']['email'] then
      mailto node['rdiff-backup']['cron']['email']
    end
    user "rdiff-backup"
    command ": Backup Summary; /etc/rdiff-backup/backup.sh 2>&1"
  end
end
