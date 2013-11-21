#
# Cookbook Name:: teamforge
# Recipe:: server
#
# Copyright 2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'rhel'
  yum_key "RPM-GPG-KEY-collabnet" do
    url "http://packages.collab.net/RPM-GPG-KEY-collabnet"
    action :add
  end

  yum_repository "collabnet" do
    repo_name "collabnet"
    description "collabnet"
    url "http://packages.collab.net/6.2.0.0/redhat/$releasever/$basearch"
    # not all CollabNet packages are signed
    # key "RPM-GPG-KEY-collabnet"
    action :add
  end

when 'suse'
  cookbook_file '/etc/zypp/repos.d/collabnet-6.2.0.0-SuSE.repo' do
    action :create
  end

else
  Chef::Log.fatal("CollabNet TeamForge Server is only supported on RHEL/CentOS or SuSE Linux distributions, and you are on #{node['platform_family']}")
end

# Teamforge expects unzip to be on systems but doesn't declare it as a RPM dep
package "unzip" do
  action :install
end

package "teamforge" do
  action :install
end

if Chef::Config[:solo]
  if node['teamforge']['server']['scm_default_shared_secret'].nil?
    Chef::Log.fatal('You must set the scm_default_shared_secret in Solo mode.')
    return
  end
  if node['teamforge']['server']['scm_default_shared_secret'].length < 16 || node['teamforge']['server']['scm_default_shared_secret'].length > 24
    Chef::Log.fatal('SCM default secret must be between 16-24 characters.')
    return
  end
else
  node.set_unless['teamforge']['server']['scm_default_shared_secret'] = (0...24).map{ ('a'..'z').to_a[rand(26)] }.join
end

template "#{node['teamforge']['server']['install_dir']}/conf/site-options.conf" do
  source "site-options.conf.erb"
  owner "root"
  group "root"
  mode 00644
  action :create
end

execute "install-collabnet-teamforge" do
  command "#{node['teamforge']['server']['install_dir']}/install.sh -n -r -I" 
  creates "#{node['teamforge']['server']['install_dir']}/install.log"
  cwd node['teamforge']['server']['install_dir']
  action :run
  notifies :run, "execute[bootstrap-data]"
end

service "collabnet" do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [:enable, :start]
end

execute "bootstrap-data" do
  command "#{node['teamforge']['server']['install_dir']}/bootstrap-data.sh"
  cwd node['teamforge']['server']['install_dir']
  action :nothing
  # The first time you install TeamForge, it automatically starts the
  # "collabnet" service in a broken state... so after bootstrap data runs,
  # restart it
  notifies :restart, "service[collabnet]"
end
