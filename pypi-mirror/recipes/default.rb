#
# Cookbook Name:: pypi-mirror
# Attributes:: default
#
# Author:: Kel Phillipson (kel@kelfish.com)
#

include_recipe "apache2"
include_recipe "python"

directory "#{node['pypi-mirror']['dir']}" do
  mode      0755
  recursive true
  not_if do
    File.exists?("#{node['pypi-mirror']['dir']}")
  end
end

directory "#{node['pypi-mirror']['cgi-dir']}" do
  owner     node['apache']['user']
  group     node['apache']['group']
  mode      0755
  recursive true
  not_if do
    File.exists?("#{node['pypi-mirror']['cgi-dir']}")
  end
end

web_app "pypi-mirror" do
  cookbook "pypi-mirror"
  template "pypi-mirror.conf.erb"
  server_name node['pypi-mirror']['server_name']
  server_aliases [node['pypi-mirror']['server_name']]
  server_base node['pypi-mirror']['dir']
  docroot "#{node['pypi-mirror']['dir']}/web"
  cgiroot "#{node['pypi-mirror']['cgi-dir']}"
end

# Enable the pypi-mirror site
apache_site "pypi-mirror" do
  enable true
end


# Install the pep381client package from PIP
python_pip "pep381client" do
  version node['pypi-mirror']['version']
  action :install
end

template "#{node['pypi-mirror']['cgi-dir']}/pep381sync.cgi" do
  source "pep381sync.cgi.erb"
  owner node['apache']['user']
  group node['apache']['group']
  mode 0777
  variables(:targetdir => node['pypi-mirror']['dir'])
end

# Initial run of the mirror, needs to be done without -q
#execute "pep381client-initial" do
#  command "/usr/local/bin/pep381run #{node['pypi-mirror']['dir']}"
#  creates "#{node['pypi-mirror']['dir']}/file"
#  action :run
#end

# Setup the cron job to sync the mirror
cron "pep381client" do
  minute node['pypi-mirror']['cron']['minute']
  hour node['pypi-mirror']['cron']['hour']
  day node['pypi-mirror']['cron']['day']
  month node['pypi-mirror']['cron']['month']
  weekday node['pypi-mirror']['cron']['weekday']

  command "/usr/local/bin/pep381run -q #{node['pypi-mirror']['dir']}"
end

# Setup the cron job to process logs back to main server
cron "pep381client-logs" do
  minute node['pypi-mirror']['logs']['minute']
  hour node['pypi-mirror']['logs']['hour']
  day node['pypi-mirror']['logs']['day']
  month node['pypi-mirror']['logs']['month']
  weekday node['pypi-mirror']['logs']['weekday']

  command "/usr/local/bin/processlogs #{node['pypi-mirror']['dir']} #{node['apache']['log_dir']}/pypi-mirror-access.log{,.1}"
end
