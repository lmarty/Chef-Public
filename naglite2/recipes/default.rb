#
# Cookbook Name:: naglite2
# Recipe:: default
#
# Copyright 2012, Green Alto
#

# From: https://github.com/lozzd/Naglite2/zipball/master

# it surely has a dependency on apache and php5
include_recipe "apache2"
include_recipe "apache2::mod_php5"

# creates correct naglite2 directory
directory "#{node[:naglite2][:dir]}" do
  owner "www-data"
  group "www-data"
  mode "0755"
  action :create
  recursive true
end

# Download naglite2 from github 
remote_file "#{Chef::Config[:file_cache_path]}/naglite2.tar.gz" do
  source "#{node[:naglite2][:repo_url]}/tarball/master"
  mode "0644"
  not_if do
    File.exists?("#{Chef::Config[:file_cache_path]}/naglite2.tar.gz")
  end
end

# uncompress it
execute "uncompress naglite2" do
  command "cd #{node[:naglite2][:dir]}; tar --strip-components=1 -xzf #{Chef::Config[:file_cache_path]}/naglite2.tar.gz"
  not_if { File.exist? "#{node[:naglite2][:dir]}/index.php"}
end

# sends the config file
template "#{node[:naglite2][:dir]}/inc.php" do
  source "inc.php.erb"
  owner "www-data"
  group "www-data"
  mode "0644"
end

# enables apache vhost
web_app 'naglite2' do
  template 'apache_vhost.erb'
end
