#
# Cookbook Name:: azure
# Recipe:: default
#
# Copyright (C) 2013 Panagiotis Papadomitsos
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Include the OHAI plugin in order to make the Azure attributes available to the rest of the recipe
if node['azure']['ohai']['override_embedded']
  include_recipe 'azure::ohai_plugin'
end

# Avoid execution of the rest of the recipe unless we are running on the Azure platform
unless node.attribute?('cloud') && node['cloud'].attribute?('provider') && node['cloud']['provider'].eql?('azure')
  Chef::Log.info('Azure cookbook included in run list but not currently running on Windows Azure platform. Skipping recipe...')
  return true 
end

case node['platform_family']
when 'rhel', 'amazon', 'scientific', 'oracle', 'fedora'

  if node['azure']['rpm']['url'] && node['azure']['rpm']['checksum']

    rpm_filename = ::File.basename(node['azure']['rpm']['url'])

    remote_file "#{Chef::Config['file_cache_path']}/#{rpm_filename}" do
      owner 'root'
      group 'root'
      mode 00644
      source node['azure']['rpm']['url']
      checksum node['azure']['rpm']['checksum']
      action :create_if_missing
    end

    rpm_package rpm_filename do
        action :install
    end
  
  else
    raise 'You have to specify a valid RPM URL for the Windows Azure Linux agent for you distribution to use this cookbook.'
  end

when 'debian'

  package 'walinuxagent' do
    action :install
  end

end

template '/etc/waagent.conf' do
  source 'waagent.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[walinuxagent]'
end

service 'walinuxagent' do
  supports :status => true, :restart => true
  provider(Chef::Provider::Service::Upstart) if (platform?('ubuntu') && node['platform_version'].to_f >= 12.04)
  action [ :enable, :start ]
end
