#
# Cookbook Name:: pvpgn
# Recipe:: default
#
# Copyright 2011, Gerald L. Hevener Jr., M.S.
#

# Install pvpgn package
deb_packages = case node['platform']
  when "ubuntu","debian"
    %w{ pvpgn }
  end

deb_packages.each do |pkg|
  package pkg do
    action :install
  end
end

# Install mysql db
if node['pvpgn']['db_type'] == "mysql"
	include_recipe "pvpgn::mysql"
end

# Install PostgreSQL DB
if node['pvpgn']['db_type'] == "pgsql"
    include_recipe "pvpgn::postgresql"
end

# Create pvpgn group
group "pvpgn" do
  gid  8000
end

# Create pvpgn user
user "pvpgn" do
  comment "PvPGN Service Account"
  uid 8000
  gid "pvpgn"
  home "/home/pvpgn"
  shell "/bin/bash"
  supports :manage_home => true
end

directory "/var/lib/pvpgn" do
  owner "pvpgn"
  group "pvpgn"
  mode "0755"
  action :create
  not_if "test -d /var/lib/pvpgn"
end

directory "/var/lib/pvpgn/files" do
  owner "pvpgn"
  group "pvpgn"
  mode "0755"
  action :create
  not_if "test -d /var/lib/pvpgn/files"
end

# Install latest version from source
# May need if distro provided package is too old
if node['pvpgn']['install_latest_from_source'] == "yes"
  bash "install_pvpgn" do
    user "root"
    cwd "/opt"
    code <<-EOH
    wget http://download.berlios.de/pvpgn/pvpgn-1.8.5.tar.gz
    tar -zxf pvpgn-1.8.5.tar.gz
    cd pvpgn-1.8.5
    ./configure --prefix=/opt
    make
    make install
	rm -f pvpgn-1.8.5.tar.gz
    EOH
	not_if "test -d /opt/pvpgn-1.8.5" 
  end
end

# Install PvPGN support files (required).
  bash "install_pvpgn_support_files" do
    user "root"
	cwd "/var/lib/pvpgn/files"
    code <<-EOH
	wget http://download.berlios.de/pvpgn/pvpgn-support-1.0.tar.gz
    tar -zxf pvpgn-support-1.0.tar.gz
    mv pvpgn-support-1.0/* .
	rm -rf pvpgn-support-1.0*
	chown -R pvpgn:pvpgn /var/lib/pvpgn
    EOH
	not_if "test -f /var/lib/pvpgn/files/bnserver.ini"
  end

# Templates for config files in /etc/pvpgn/*
template "#{node['pvpgn']['conf_dir']}/ad.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "ad.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/address_translation.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "address_translation.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/anongame_infos.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "anongame_infos.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/autoupdate.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "autoupdate.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/bnalias.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "bnalias.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/bnban.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "bnban.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/bnetd.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "bnetd.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/bnetd_default_user.plain" do
  mode "0644"
  owner "root"
  group "root"
  source "bnetd_default_user.plain.erb"
end

template "#{node['pvpgn']['conf_dir']}/bnhelp.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "bnhelp.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/bnissue.txt" do
  mode "0644"
  owner "root"
  group "root"
  source "bnissue.txt.erb"
end

template "#{node['pvpgn']['conf_dir']}/bnmaps.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "bnmaps.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/bnmotd.txt" do
  mode "0644"
  owner "root"
  group "root"
  source "bnmotd.txt.erb"
end

template "#{node['pvpgn']['conf_dir']}/bnxpcalc.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "bnxpcalc.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/bnxplevel.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "bnxplevel.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/channel.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "channel.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/command_groups.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "command_groups.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/d2cs.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "d2cs.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/d2dbs.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "d2dbs.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/d2server.ini" do
  mode "0644"
  owner "root"
  group "root"
  source "d2server.ini.erb"
end

template "#{node['pvpgn']['conf_dir']}/news.txt" do
  mode "0644"
  owner "root"
  group "root"
  source "news.txt.erb"
end

template "#{node['pvpgn']['conf_dir']}/realm.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "realm.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/sql_DB_layout2.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "sql_DB_layout2.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/sql_DB_layout2.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "sql_DB_layout2.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/sql_DB_layout.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "sql_DB_layout.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/supportfile.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "supportfile.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/topics.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "topics.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/tournament.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "tournament.conf.erb"
end

template "#{node['pvpgn']['conf_dir']}/versioncheck.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "versioncheck.conf.erb"
end

cookbook_file "/etc/pvpgn/bnetd_default_user.cdb" do
  source "bnetd_default_user.cdb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

service "pvpgn" do
  supports :enable => true, :start => true, :restart => true
  action [ :enable, :start ]      
end
