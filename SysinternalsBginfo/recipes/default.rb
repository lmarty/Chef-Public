#
# Cookbook Name:: SysinternalsBginfo
# Recipe:: default
#
# Copyright 2013, Electronic Arts, Game Development Services
#
# Author: Shaun McDonnell (smcdonnell@ea.com)

# the downloaded zip file.
bginfo_zip_file                 = ::File.basename(node['SysinternalsBginfo']['sysinternals_download_url'])

# the bginfo configuration file (typically Config.bgi).
bginfo_bgi_configuration_file   = "#{node['SysinternalsBginfo']['bginfo_installation_directory']}\\Config.bgi"

# the background to be displayed
bginfo_bgi_background           = "#{node['SysinternalsBginfo']['bginfo_installation_directory']}\\Background.jpg"

# create the local by downloading the remote file from sysinternals
remote_file "#{Chef::Config[:file_cache_path]}/#{bginfo_zip_file}" do
  source node['SysinternalsBginfo']['sysinternals_download_url']
  notifies :unzip, "windows_zipfile[bginfozip]", :immediately
end

# unzip the downloaded file to the installation directory
windows_zipfile "bginfozip" do
  path node['SysinternalsBginfo']['bginfo_installation_directory']
  source "#{Chef::Config[:file_cache_path]}/#{bginfo_zip_file}"
  action :unzip
  not_if { ::File.exists?("#{node['SysinternalsBginfo']['bginfo_installation_directory']}/bginfo.exe") }
end

# create the bginfo configuration file if it doesn't exist
cookbook_file bginfo_bgi_configuration_file do
  source "Config.bgi"
  action :create_if_missing
end

# create the background jpeg file if it doesn't exist
cookbook_file bginfo_bgi_background do
  source "Background.jpg"
  action :create_if_missing
  notifies :run, "execute[fix-permissions]", :immediately
end

# reset the bginfo configuration file permissions
execute "fix-permissions" do
  command "icacls #{bginfo_bgi_configuration_file} /reset"
  command "icacls #{bginfo_bgi_background} /reset"
  action :nothing
end

registry_key "HKEY_CURRENT_USER\\Software\\Winternals\\BgInfo" do
  values [{
    :name => "Wallpaper",
    :type => :string,
    :data => "#{node['SysinternalsBginfo']['bginfo_installation_directory']}\\Background.jpg"
  }]
  recursive true
  action :create
end

# set windows to automatically run bginfo by creating a registry value
windows_auto_run 'BGINFO' do
  program "#{node['SysinternalsBginfo']['bginfo_installation_directory']}\\bginfo.exe"
  args "\"#{bginfo_bgi_configuration_file}\" /NOLICPROMPT /TIMER:0"
  not_if { Registry.value_exists?(AUTO_RUN_KEY, 'BGINFO') }
  action :create
end
