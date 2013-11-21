#
# Chef Cookbook   : eos
# File            : recipes/interface.rb
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
if config.has_key?('interfaces')
  config['interfaces'].each do |name, attribs|
    Chef::Log.info "Processing interface #{name}"

    if attribs['state'] == 'default'
      eos_interface name do
        action :default
      end
    
    else
      eos_interface name do
        admin attribs['admin'] if attribs['admin']
        description attribs['description'] if attribs['description']
        action :manage
      end
    end
    
  end
else
  Chef::Log.fatal "Could not load interface configuration"
end





