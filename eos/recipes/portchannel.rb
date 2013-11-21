#
# Chef Cookbook   : eos
# File            : recipes/portchannel.rb
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
config = get_config()
if config.has_key?('portchannel')
  config['portchannel'].each do |name, attribs|
    Chef::Log.info "Processing port-channel #{name}"

    if attribs['state'] == 'absent'
      eos_portchannel name do
        action :remove
      end
    
    else
      eos_portchannel name do
        links attribs['links'] if attribs['links']
        minimum_links attribs['minimum_links'].to_i if attribs['minimum_links']
        lacp attribs['lacp'] if attribs['lacp']
        action :manage
      end
    end
    
  end
else
  Chef::Log.fatal "Could not load port-channel configuration"
end





