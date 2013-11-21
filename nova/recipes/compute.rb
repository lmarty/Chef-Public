#
# Cookbook Name:: nova
# Recipe:: compute
#
# Copyright 2012, Rackspace US, Inc.
# Copyright 2012-2013, Opscode, Inc.
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

include_recipe "nova::nova-common"
include_recipe "nova::api-metadata"
include_recipe "nova::network"

platform_options = node["nova"]["platform"]

platform_options["nova_compute_packages"].each do |pkg|
  package pkg do
    action :install
    options platform_options["package_overrides"]
  end
end

cookbook_file "/etc/nova/nova-compute.conf" do
  source "nova-compute.conf"
  mode "0644"
  action :create
end

service "nova-compute" do
  service_name platform_options["nova_compute_service"]
  supports :status => true, :restart => true
  action :enable
  subscribes :restart, "template[/etc/nova/nova.conf]"
end

include_recipe "nova::libvirt"

# Sysctl tunables
sysctl_multi "nova" do
  instructions "net.ipv4.ip_forward" => "1"
end
