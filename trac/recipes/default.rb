#
# Cookbook Name:: trac
# Recipe:: default
#
# Copyright 2009, Peter Crossley <peterc@xley.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_fcgid"
include_recipe "apache2::mod_deflate"

package "trac" do
  action :install
end

directory node['trac']['basedir'] do
  owner "root"
  group "root"
  mode 00755
end

directory "#{node['trac']['basedir']}/cgi-bin" do
  owner "root"
  group "root"
  mode 00755
end

template "trac-fcgi" do
  path "#{node['trac']['basedir']}/cgi-bin/trac.fcgi"
  source "trac.fcgi.erb"
  owner "root"
  group "root"
  mode 00755
  variables(
    :trac_environment => "#{node['trac']['basedir']}/environment"
  )
end

execute "trac-environment" do
  command "trac-admin #{node['trac']['basedir']}/environment initenv '#{node['trac']['project_name']}' 'sqlite:db/trac.db' svn #{node['trac']['svn_dir']}"
  only_if "/usr/bin/test ! -d #{node['trac']['basedir']}/environment"
end

directory "#{node['trac']['basedir']}/environment" do
  owner node['apache']['user']
  group node['apache']['group']
  recursive true
end

execute "trac-owner-change" do
  command "chown -Rf #{node['apache']['user']}:#{node['apache']['group']} #{node['trac']['basedir']}/environment"
end

template "trac-ini" do
  path "#{node['trac']['basedir']}/environment/conf/trac.ini"
  source "trac.ini.erb"
  owner node['apache']['user']
  group node['apache']['group']
  mode 0775
  variables(
    :trac_project_desc => node['trac']['project_description'],
    :trac_project_name => node['trac']['project_name'],
    :trac_mainnav => node['trac']['mainnav'],
    :trac_metanav => node['trac']['metanav'],
    :trac_url => node['trac']['vhosts'].first,
    :trac_svn_branches => node['trac']['svn_branches'],
    :trac_svn_tags => node['trac']['svn_tags'],
    :trac_svn_repo => node['trac']['svn_dir']
  )
end

template "trac-conf" do
  path "#{node['apache']['dir']}/sites-available/trac.conf"
  source "trac.conf.erb"
  owner "root"
  group "root"
  mode 00644
  variables(
    :trac_dir => node['trac']['basedir'],
    :trac_project_name => node['trac']['project_name'],
    :trac_required_groups => node['trac']['required_groups'],
    :trac_vhosts => node['trac']['vhosts']
  )
end

apache_site "trac.conf"

apache_site "default" do
  enable  false
end

# help keep the repo in sync
cron "trac-sync" do
  minute "0"
  command "trac-admin #{node['trac']['basedir']}/environment resync"
  user node['apache']['user']
  only_if do ::File.exists?("#{node['trac']['basedir']}/environment") end
end
