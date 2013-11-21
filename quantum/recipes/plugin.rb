#
# Cookbook Name:: Quantum 
# Recipe:: plugin 
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

case node["openstack"]["quantum"]["plugin"]
when "nicira"
  package "quantum-plugin-nicira"
  provider = "quantum.plugins.nicira.nicira_nvp_plugin.QuantumPlugin.NvpPluginV2"
when "linuxbridge"
  package "quantum-plugin-linuxbridge-agent"
  provider = "quantum.plugins.linuxbridge.lb_quantum_plugin.LinuxBridgePluginV2"
when "cisco"
  package "quantum-plugin"
  provider = "quantum.plugins.cisco.network_plugin.PluginV2"
when "openvswitch"
  package "quantum-plugin-openvswitch"
  provider = "quantum.plugins.openvswitch.ovs_quantum_plugin.OVSQuantumPlugin"
when "ryu"
  package "quantum-plugin-ryu"
  provider = "quantum.plugins.ryu.ryu_quantum_plugin.RyuQuantumPluginV2"
end

template "/etc/quantum/plugins.ini" do
  source "plugins.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
            "plugin_provider" => provider
            )
end

mysql_info = get_settings_by_role("mysql-master", "mysql")

create_db_and_user("mysql",
                    node["openstack"]["quantum"]["db"]["name"],
                    node["openstack"]["quantum"]["db"]["username"],
                    node["openstack"]["quantum"]["db"]["password"])

case node["openstack"]["quantum"]["plugin"]
when "nicira"
  directory "/etc/quantum/plugins/nicira" do
    recursive true
    owner "root"
    group "root"
    mode "0755"
  end

  template "/etc/quantum/plugins/nicira/nvp.ini" do
    source "plugins/nicira/nvp.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(
      "mysql_pass" => node["openstack"]["quantum"]["db"]["password"],
      "mysql_host" => mysql_info["bind_address"],
      "mysql_user" => node["openstack"]["quantum"]["db"]["username"],
      "tz_uuid" => node["quantum"]["plugin"]["nvp"]["tz_uuid"]
    )
  end
#TODO add logic for setting up additional plugins
when "linuxbridge"
  #
when "cisco"
  #
when "openvswitch"
  #
when "ryu"
  #
end

service "quantum-server" do
     action :restart
end
