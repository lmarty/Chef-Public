#
# Cookbook Name:: el2centos
# Recipe:: default
#
# Copyright 2012, Eric G. Wolfe
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

# When redhat, fetch the centos rpms, and attempt to convert and upgrade
case node['platform']
when "redhat"
  execute "yum clean all"

  yum_key "RPM-GPG-KEY-CentOS-#{node['platform_version'].to_i}" do
    url node['el2centos']['centos_key']
    action :add
  end

  directory node['el2centos']['conversion_path'] do
    owner "root"
    group "root"
    mode 0755
    recursive true
    action :create
  end

  node['el2centos']['rpms'].each do |centos_rpm|
    remote_file "#{node['el2centos']['conversion_path']}/#{centos_rpm}" do
      source "#{node['el2centos']['rpm_url']}/#{centos_rpm}"
    end
  end

  node['el2centos']['rpms2remove'].each do |el_rpm|
    rpm_package el_rpm do
      options "--nodeps"
      action :remove
      ignore_failure true
    end
  end

  execute "rpm -Uvh --force #{node['el2centos']['conversion_path']}/*.rpm"

  [ "yum -q makecache", "yum -y upgrade" ].each do |yum_cmd|
    execute yum_cmd
  end

# If the process was interrupted, it may have changed our platform.
# Try to remove any remaining redhat files, and convert to centos.
when "linux"
  node['el2centos']['rpms2remove'].each do |el_rpm|
    rpm_package el_rpm do
      options "--nodeps"
      action :remove
      ignore_failure true
    end
  end

  execute "rpm -Uvh --force #{node['el2centos']['conversion_path']}/*.rpm"

  [ "yum -q makecache", "yum -y upgrade" ].each do |yum_cmd|
    execute yum_cmd
  end

# Otherwise, cannot safely attempt to convert this system.
# Throw out a warning and remove the recipe.
else
  Chef::Log.warn("Platform #{node['platform']} cannot be converted to CentOS!")
  ruby_block "Removing el2centos recipe from run_list" do
    block do
      node.run_list.remove("recipe[el2centos]")
    end
  end
end
