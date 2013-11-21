#
# Chef Cookbook   : eos
# File            : recipe/default.rb
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

netdev_provider = node[:netdev_config][:providers][:netdev_interface]
Chef::Log.info "My provider is #{netdev_provider}"

config = data_bag_item(databag, hostname)
interfaces = config['netdev_interface']

if !interfaces.nil?
  interfaces.each do |name, attribs|
    Chef::Log.info "Processing interface #{name}"

    if attribs['state'] == 'default'
      netdev_interface name do
        provider netdev_provider
        action :delete
      end
    
    else
      netdev_interface name do
        provider netdev_provider
        admin attribs['admin'] if attribs['admin']
        description attribs['description'] if attribs['description']
        mtu attribs['mtu'].to_i if attribs['mtu']
        speed attribs['speed'] if attribs['speed']
        duplex attribs['duplex'] if attribs['duplex']
        action :create
      end
    end
    
  end
end




