#
# Chef Cookbook   : netdev_eos
# Recipe          : l2_interface
#    
# Copyright 2013 Arista Networks
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
databag = node[:netdev_config][:databag_name]
Chef::Log.info "My data bag is #{databag}"

hostname = node[:hostname]
Chef::Log.info "My hostname is #{hostname}"

config = data_bag_item(databag, hostname)
interfaces = config['netdev_l2_interface']

netdev_provider = node[:netdev_config][:providers][:netdev_l2_interface]
Chef::Log.info "My provider is #{netdev_provider}"

if !interfaces.nil?
  interfaces.each do |name, attribs|
    Chef::Log.info "Processing l2interface #{name}"

    if attribs['state'] == 'absent'
      netdev_l2_interface name do
        provider netdev_provider
        action :delete
      end
    
    else
      netdev_l2_interface name do
        provider netdev_provider
        description attribs['description'] if attribs['description']
        untagged_vlan attribs['untagged_vlan'] if attribs['untagged_vlan']
        tagged_vlans attribs['tagged_vlans'] if attribs['tagged_vlans']
        vlan_tagging attribs['vlan_tagging'] if attribs['vlan_tagging']
        action :create
      end
    end
    
  end
end

