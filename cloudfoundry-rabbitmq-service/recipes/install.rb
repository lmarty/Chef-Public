#
# Cookbook Name:: cloudfoundry-rabbitmq-service
# Recipe:: install
#
# Copyright 2012-2013, ZephirWorks
# Copyright 2011, VMware
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

node.set['cloudfoundry_rabbitmq_service']['node']['versions']['2.4'] = {}
rabbit24cfg = node['cloudfoundry_rabbitmq_service']['node']['versions']['2.4']
rabbit24cfg['rabbitmq_base_path'] = node['cloudfoundry_rabbitmq_service']['path']
rabbit24cfg['config_template'] = "rabbitmq24.config.erb"

case node['platform']
when "ubuntu"
  package "erlang-nox"

  remote_file File.join("", "tmp", "rabbitmq-server-#{node['cloudfoundry_rabbitmq_service']['version_full']}.tar.gz") do
    owner node['cloudfoundry']['user']
    source node['cloudfoundry_rabbitmq_service']['source']
    not_if { ::File.exists?(File.join("", "tmp", "rabbitmq-server-#{node['cloudfoundry_rabbitmq_service']['version_full']}.tar.gz")) }
  end

  node['cloudfoundry_rabbitmq_service']['plugins'].each do |plugin_name|
    remote_file File.join("", "tmp", "#{plugin_name}-#{node['cloudfoundry_rabbitmq_service']['version']}.ez") do
      owner node['cloudfoundry']['user']
      source "#{node['cloudfoundry_rabbitmq_service']['plugins_source']}#{plugin_name}-#{node['cloudfoundry_rabbitmq_service']['version']}.ez"
      not_if { ::File.exists?(File.join("", "tmp", "#{plugin_name}-#{node['cloudfoundry_rabbitmq_service']['version']}.ez")) }
    end
  end

  directory node['cloudfoundry_rabbitmq_service']['path'] do
    owner node['cloudfoundry']['user']
    mode "0755"
    recursive true
  end

  bash "Install RabbitMQ" do
    cwd File.join("", "tmp")
    user node['cloudfoundry']['user']
    code <<-EOH
    tar xzf rabbitmq-server-#{node['cloudfoundry_rabbitmq_service']['version_full']}.tar.gz
    cd rabbitmq_server-#{node['cloudfoundry_rabbitmq_service']['version']}
    cp -rf * #{node['cloudfoundry_rabbitmq_service']['path']}
    EOH
    not_if do
      ::File.exists?(File.join(node['cloudfoundry_rabbitmq_service']['path'], "sbin", "rabbitmq-server"))
    end
  end

  node['cloudfoundry_rabbitmq_service']['plugins'].each do |plugin_name|
    bash "Install RabbitMQ #{plugin_name} plugin" do
      cwd File.join("", "tmp")
      user node['cloudfoundry']['user']
      code <<-EOH
      cp -f "#{plugin_name}-#{node['cloudfoundry_rabbitmq_service']['version']}.ez" #{File.join(node['cloudfoundry_rabbitmq_service']['path'], "plugins")}
      EOH
      not_if do
        ::File.exists?(File.join(node['cloudfoundry_rabbitmq_service']['path'], "plugins", "#{plugin_name}-#{node['cloudfoundry_rabbitmq_service']['version']}.ez"))
      end
    end
  end
else
  Chef::Log.error("Installation of rabbitmq packages not supported on this platform.")
end
