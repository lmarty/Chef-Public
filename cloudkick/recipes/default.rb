#
# Cookbook Name:: cloudkick
# Recipe:: default
#
# Copyright 2010-2011, Opscode, Inc.
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

case node['platform_family']
when "debian"

  if node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 11.10
    codename = 'lucid'
  else
    codename = node['lsb']['codename']
  end

  apt_repository "cloudkick" do
    uri "http://packages.cloudkick.com/ubuntu"
    distribution codename
    components ["main"]
    key "http://packages.cloudkick.com/cloudkick.packages.key"
    action :add
  end

  if node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 11.10
    package "libssl0.9.8"
  end

when "rhel", "fedora"

  # Don't use the cloudkick yum repository on CentOS 6, because there
  # will be a missing libcurl.so.3 dependency (was that CentOS 5 only?).
  unless (node['platform'] == 'centos' && node['platform_version'].to_f >= 6.0)

    yum_repository "cloudkick" do
      url "http://packages.cloudkick.com/redhat/$basearch"
      action :add
    end

  else

    # https://support.cloudkick.com/Installing_Cloudkick_on_AMI,_CentOS,_and_Red_Hat
    # For CentOS 6, we must download and install beta binaries "by hand"
    # for cloudkick-config-1.2.1-0 and cloudkick-agent-0.9.21-0 packages.
    config_ver = "1.2.1-0"
    agent_ver = "0.9.21-0"
    arch = node['kernel']['machine']

    remote_file "#{Chef::Config[:file_cache_path]}/cloudkick-config-centos6-#{config_ver}.#{arch}.rpm" do
      not_if "rpm -qa | egrep -qx 'cloudkick-config-#{config_ver}.*'"
      source "http://packages.cloudkick.com/releases/cloudkick-config/binaries/cloudkick-config-centos6-#{config_ver}.#{arch}.rpm"
      notifies :install, "rpm_package[cloudkick-config]", :immediately
      retries 5 # We may be redirected to a FTP URL, CHEF-1031.
    end

    rpm_package "cloudkick-config" do
      not_if "rpm -qa | egrep -qx 'cloudkick-config-#{config_ver}.*'"
      source "#{Chef::Config[:file_cache_path]}/cloudkick-config-centos6-#{config_ver}.#{arch}.rpm"
      action :install
    end

    remote_file "#{Chef::Config[:file_cache_path]}/cloudkick-agent-centos6-#{agent_ver}.#{arch}.rpm" do
      not_if "rpm -qa | egrep -qx 'cloudkick-agent-#{agent_ver}.*'"
      source "http://packages.cloudkick.com/releases/cloudkick-agent/binaries/cloudkick-agent-centos6-#{agent_ver}.#{arch}.rpm"
      notifies :install, "rpm_package[cloudkick-agent]", :immediately
      retries 5 # We may be redirected to a FTP URL, CHEF-1031.
    end

    rpm_package "cloudkick-agent" do
      not_if "rpm -qa | egrep -qx 'cloudkick-agent-#{agent_ver}.*'"
      source "#{Chef::Config[:file_cache_path]}/cloudkick-agent-centos6-#{agent_ver}.#{arch}.rpm"
      action :install
    end

  end

end

remote_directory node['cloudkick']['local_plugins_path'] do
  source "plugins"
  mode "0755"
  files_mode "0755"
  files_backup 0
  recursive true
end

# On CentOS 6, we used rpm_package for cloudkick installation instead of
# using an apt_repository or yum_repository.
unless (node['platform'] == 'centos' && node['platform_version'].to_f >= 6.0)
  package "cloudkick-agent" do
    action :install
  end
end

# The configure recipe is broken out so that reconfiguration
# is lightening fast (no package installation checks, etc).
include_recipe "cloudkick::configure"

# oauth gem for http://tickets.opscode.com/browse/COOK-797
chef_gem "oauth"
chef_gem "cloudkick"

# This seems to require chef-server search capability,
# but it times out harmlessly when using chef-solo.
ruby_block "cloudkick data load" do
  block do
    require 'oauth'
    require 'cloudkick'
    begin
      node.set['cloudkick']['data'] = Chef::CloudkickData.get(node)
    rescue Exception => e
      Chef::Log.warn("Unable to retrieve Cloudkick data for #{node.name}\n#{e}")
    end
  end
  action :create
end
