#
# Cookbook Name:: bginfo
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

file_name = ::File.basename(node['bginfo']['url'])
config_file_name = "#{node['bginfo']['home']}\\Config.bgi"

remote_file "#{Chef::Config[:file_cache_path]}/#{file_name}" do
  source node['bginfo']['url']
  notifies :unzip, "windows_zipfile[bginfozip]", :immediately
end

windows_zipfile "bginfozip" do
  path node['bginfo']['home']
  source "#{Chef::Config[:file_cache_path]}/#{file_name}"
  action :unzip
  not_if { ::File.exists?("#{node['bginfo']['home']}/bginfo.exe") }
end

cookbook_file config_file_name do
  source "Config.bgi"
  action :create_if_missing
  notifies :run, "execute[fix-permissions]", :immediately
end

execute "fix-permissions" do
  command "icacls #{config_file_name} /reset"
  action :nothing
end

# Run BGInfo at login
windows_auto_run 'BGINFO' do
  program "#{node['bginfo']['home']}\\bginfo.exe"
  args "\"#{config_file_name}\" /NOLICPROMPT /TIMER:0"
  not_if { Registry.value_exists?(AUTO_RUN_KEY, 'BGINFO') }
  action :create
end
