#
# Cookbook Name:: doozer
# Recipe:: default
#
# Author:: John Bellone <john.bellone.jr@gmail.com>
#
# Copyright 2013, John Bellone, Jr.
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

include_recipe "doozer::doozerd"

options = {
  :doozerd_user => node[:doozerd][:user],
  :doozerd_path => node[:doozerd][:install_prefix]
}

options['doozerd_options'] = node[:doozerd][:run_options].map do |k,v|
  case k.to_sym
    when :listen_port
    "-l '127.0.0.1:#{v}'"
    when :web_port
    "-w '127.0.0.1:#{v}'"
    when :boot_address
    "-b '#{v}'"
    when :name
    "-c '#{v}'"
    when :history
    "-hist #{v}"
    when :timeout
    "-timeout #{v}"
    when :pulse
    "-pulse #{v}"
    when :fill
    "-fill #{v}"
    when :attach_addresses
    k.to_enum(:to_s).map {|a| "-a '#{a}'"}.join(' ')
  end
end.join(' ')

template "doozerd" do
  case node[:platform]
    when 'ubuntu'
    path '/etc/init/doozerd.conf'
    source 'doozerd.conf.erb'
    mode 00644
    when 'redhat', 'centos'
    path '/etc/init.d/doozerd'
    source 'doozerd.init.erb'
    mode 00755
  end

  owner node[:doozerd][:user]
  group node[:doozerd][:user_group]
  notifies :restart, 'service[doozerd]'
  variables options
end

service "doozerd" do
  case node[:platform]
    when 'ubuntu'
    provider Chef::Provider::Service::Upstart
    action :enable
    else
    provider Chef::Provider::Service::Init
  end

  supports [:restart, :status, :start, :stop]
end

service "doozerd" do
  action :start
end
