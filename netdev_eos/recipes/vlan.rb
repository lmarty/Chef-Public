#
# Chef Cookbook   : netdev_eos
# Recipe          : vlan
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
vlans = config['netdev_vlan']

netdev_provider = node[:netdev_config][:providers][:netdev_vlan]
Chef::Log.info "My provider is #{netdev_provider}"

if !vlans.nil?
  vlans.each do |name, attribs|
    Chef::Log.info "Processing vlan #{name}"

    if attribs['state'] == 'absent'
      netdev_vlan name do
        provider netdev_provider
        vlan_id attribs['vlan_id'].to_i
        action :delete
      end
    
    else
      netdev_vlan name do
        provider netdev_provider
        vlan_id attribs['vlan_id'].to_i
        action :create
      end
    end
    
  end
end

