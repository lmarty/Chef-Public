#
# Cookbook Name:: ircd-ratbox
# Recipe:: default
#
# Copyright 2011, Łukasz Jernaś
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

package "ircd-ratbox"

service "ircd" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

template "/etc/ircd/ircd.conf" do
  source "ircd.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
    :server_port => node[:ircd][:port],
    :server_admin_name => node[:ircd][:admin][:name],
    :server_admin_email => node[:ircd][:admin][:email],
    :server_name => node[:ircd][:name],
    :server_ip => node[:ircd][:ip],
    :server_user => node[:ircd][:auth][:user],
    :server_class => node[:ircd][:auth][:class],
    :server_description => node[:ircd][:description],
    :network_name => node[:ircd][:network_name],
    :network_description => node[:ircd][:network_description],
    :user_classes => node[:ircd][:auth][:classes],
    :user_class_mapping => node[:ircd][:auth][:class_mapping]
  )
  notifies :reload, resources(:service => "ircd")
end

template "/etc/ircd/ircd.motd" do
  source "motd.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
    :server_motd => node[:ircd][:motd]
  )
end

