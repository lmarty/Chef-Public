#
# Cookbook Name:: Quantum 
# Recipe:: server
#
# Copyright 2013, Opscode, Inc.
# Copyright 2012, DreamHost
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
#

rabbit_info = get_settings_by_role("rabbitmq-server", "rabbitmq")
keystone = get_settings_by_role("keystone", "keystone")
ks_admin_endpoint = get_access_endpoint("keystone", "keystone", "admin-api")
ks_service_endpoint = get_access_endpoint("keystone", "keystone", "service-api")
api_endpoint = get_bind_endpoint("quantum", "api")

# Allow for using a well known db password
if node["developer_mode"]
  node.set_unless["openstack"]["quantum"]["db"]["password"] = "quantum"
else
  node.set_unless["openstack"]["quantum"]["db"]["password"] = secure_password
end

# Allow for using a well known db password
if node["developer_mode"]
  node.set_unless["openstack"]["quantum"]["service_pass"] = "quantum"
else
  node.set_unless["openstack"]["quantum"]["service_pass"] = secure_password
end

if node["openstack"]["quantum"]["api_extensions_path"]
  api_extensions_path = node["openstack"]["quantum"]["api_extensions_path"]
else
  api_extensions_path = ""
end

# Register Service Tenant
keystone_register "Register Quantum Service Tenant" do
  auth_host ks_admin_endpoint["host"]
  auth_port ks_admin_endpoint["port"]
  auth_protocol ks_admin_endpoint["scheme"]
  api_ver ks_admin_endpoint["path"]
  auth_token keystone["admin_token"]
  tenant_name node["openstack"]["quantum"]["service_tenant_name"]
  user_name node["openstack"]["quantum"]["service_user"]
  user_pass node["openstack"]["quantum"]["service_pass"]
  tenant_description "Quantum Service Tenant"
  tenant_enabled "true" # Not required as this is the default
  action :create_user
end

package "quantum-server"

service "quantum-server" do
     action [:enable, :start]
     supports :restart => true
end

case node["openstack"]["quantum"]["plugin"]
when "nicira"
  provider = "quantum.plugins.nicira.nicira_nvp_plugin.QuantumPlugin.NvpPluginV2"
when "linuxbridge"
  provider = "quantum.plugins.linuxbridge.lb_quantum_plugin.LinuxBridgePluginV2"
when "cisco"
  provider = "quantum.plugins.cisco.network_plugin.PluginV2"
when "openvswitch"
  provider = "quantum.plugins.openvswitch.ovs_quantum_plugin.OVSQuantumPlugin"
when "ryu"
  provider = "quantum.plugins.ryu.ryu_quantum_plugin.RyuQuantumPluginV2"
end

template "/etc/quantum/quantum.conf" do
  source "quantum.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    "rabbit_ipaddress" => IPManagement.get_ips_for_role("rabbitmq-server","nova",node)[0],
    "api_extensions_path" => api_extensions_path,
    "provider" => provider
  )
end

template "/etc/quantum/api-paste.ini" do
  source "api-paste.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    "component"  => node["package_component"],
    "use_syslog" => node["openstack"]["quantum"]["syslog"]["use"],
    "log_facility" => node["openstack"]["quantum"]["syslog"]["facility"],
    "keystone_api_ipaddress" => ks_admin_endpoint["host"],
    "keystone_service_port" => ks_service_endpoint["port"],
    "keystone_admin_port" => ks_admin_endpoint["port"],
    "keystone_admin_token" => keystone["admin_token"],
    "service_tenant_name" => node["openstack"]["quantum"]["service_tenant_name"],
    "service_user" => node["openstack"]["quantum"]["service_user"],
    "service_pass" => node["openstack"]["quantum"]["service_pass"]
  )
 notifies :restart, "service[nova-api-os-compute]"
end

# Register Network Service
keystone_register "Register Network Service" do
  auth_host ks_admin_endpoint["host"]
  auth_port ks_admin_endpoint["port"]
  auth_protocol ks_admin_endpoint["scheme"]
  api_ver ks_admin_endpoint["path"]
  auth_token keystone["admin_token"]
  service_name "quantum"
  service_type "network"
  service_description "Quantum Network Service"
  action :create_service
end

# Register Network Endpoint
keystone_register "Register Network Endpoint" do
  auth_host ks_admin_endpoint["host"]
  auth_port ks_admin_endpoint["port"]
  auth_protocol ks_admin_endpoint["scheme"]
  api_ver ks_admin_endpoint["path"]
  auth_token keystone["admin_token"]
  service_type "network"
  endpoint_region "RegionOne"
  endpoint_adminurl api_endpoint["uri"]
  endpoint_internalurl api_endpoint["uri"]
  endpoint_publicurl api_endpoint["uri"]
  action :create_endpoint
  notifies :restart, "service[quantum-server]", :immediately
end
