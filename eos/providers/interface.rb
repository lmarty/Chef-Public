#
# Chef Cookbook   : eos
# File            : provider/interface.rb
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

def whyrun_supported?
  true
end

action :manage do  
  converge_by("manage interface #{new_resource.name}") do
    params = Array.new()
    (params << "--admin" << new_resource.admin) if has_changed?(current_resource.admin, new_resource.admin)
    (params << "--description" << %Q{"#{new_resource.description}"}) if has_changed?(current_resource.description, new_resource.description)
    
    if !params.empty?
      execute "netdev interface edit" do
        Chef::Log.debug "Command: netdev interface edit #{new_resource.name} #{params.join(' ')}"
        command "netdev interface edit #{new_resource.name} #{params.join(' ')}"
      end
    else
      Chef::Log.info "No attributes have changed"
    end
  end
end

action :default do
  converge_by("remove interface #{new_resource.name}") do
    execute "netdev interface delete" do
      command "netdev interface delete #{new_resource.name}"
    end
  end
end

def load_current_resource
  Chef::Log.info "Loading current resource #{@new_resource.name}"
  
  resp = eval run_command("netdev interface list --output ruby-hash")
  if !resp.nil?
    interface = resp['result'][@new_resource.name]
  
    @current_resource = Chef::Resource::EosInterface.new(@new_resource.name)
    @current_resource.admin(interface['admin'])
    @current_resource.description(interface['description'])
    @current_resource.admin(interface['admin'])
    @current_resource.exists = true

  else
    Chef::Log.fatal "Unable to load current resource"
    
  end

end

  
