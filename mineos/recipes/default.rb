#
# Cookbook Name:: mineos
# Recipe:: default
#
# Copyright 2013, ka’imi
#

dir = node['mineos']['basedir']

# /usr/games/minecraft symlink || abort
if Dir.exists?("/usr/games/minecraft") && !File.symlink?("/usr/games/minecraft") then
  Chef::Log.fatal("'/usr/games/minecraft' directory exists; please remove any old version of mineos before installing using this cookbook.")
  raise "'/usr/games/minecraft' directory exists; please remove any old version of mineos before installing using this cookbook."
end

link "/usr/games/minecraft" do
  to "#{dir}/current"
end

# install required packages
%w{ screen python-cherrypy3 rdiff-backup git openjdk-7-jre-headless }.each do |p|
  package p
end

# create config file
directory "#{dir}/shared" do
  recursive true
end
template "#{dir}/shared/mineos.conf" do
  source "mineos.conf.erb"
end
link "/etc/mineos.conf" do
  to "#{dir}/current/mineos.conf"
end

# deploy the latest version
deploy_revision dir do
  repo node['mineos']['repository']
  branch node['mineos']['version']
  shallow_clone true
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink %w{ mineos.conf }
  symlinks(
    "mineos.conf" => "mineos.conf"
  )
  notifies :restart, "service[mineos]", :immediately
end

# generate self signed SSL cert
if node['mineos']['config']['ssl']['generate'] && (!File.exists?(node['mineos']['config']['ssl']['cert']) || !File.exists?(node['mineos']['config']['ssl']['key'])) then
  execute "generate certs" do
    command "sh generate-sslcert.sh"
    cwd "#{dir}/current"
  end
end

# services, copy da filez0rs
%w{ mineos minecraft}.each do |f|
  remote_file "/etc/init.d/#{f}" do
    source "file://#{dir}/current/init/#{f}"
    mode 0755
    notifies :restart, "service[#{f}]"
  end
end

# enable the services
service "minecraft" do
  action :enable
end
service "mineos" do
  action :enable
end

grp = node['mineos']['group']
group grp do
  append true
end
# set group rights to create profiles
file "/var/games/minecraft/profiles/profile.config" do
  group grp
  mode 0755
end

# profile fix
if node['mineos']['profile_fix']['enable'] then
  template "#{dir}/current/stock_profiles.py" do
    source "stock_profiles.py.erb"
    group grp
    variables({
      :versions => node['mineos']['profile_fix']['versions']
    })
  end
end

# logrotate
logrotate_app "mineos" do
  cookbook "logrotate"
  path "/var/log/mineos.log"
  rotate 12
end
