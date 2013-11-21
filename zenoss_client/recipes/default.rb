#
# Cookbook Name:: zenoss_client
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Lets try and locate the zenoss server responsible for this node
server = nil
pubkey = ""
if node['zenoss']['client']['server'].nil?
  if Chef::Config["solo"]
    Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
  else
    servers = search(:node, 'recipes:zenoss\:\:server') || []
    if servers.length > 0
      server = servers.first
      
      # Get the public key from search if its available
      unless server.nil?
        if server.attribute?("zenoss")
         if server['zenoss'].attribute?('server')
           if server['zenoss']['server'].attribute?('zenoss_pubkey')
             pubkey = zenoss["server"]["zenoss_pubkey"]
           end
         end
        end
      end
      
    end
  end
else
  server = node['zenoss']['client']['server']
end

if node['zenoss']['client']['create_local_user'] == true
  user node['zenoss']['client']['local_user_name'] do
    comment node['zenoss']['client']['local_user_comment']
    unless node['os'] == "windows"
      home node['zenoss']['client']['local_user_homedir']
      supports :manage_home => true
      shell node['zenoss']['client']['local_user_shell']
    end
    action :create
  end
 
  # Now create the ssh authorized keys on those os's that support it
  unless node['os'] == "windows"
    ssh_dir = ::File.join(node['zenoss']['client']['local_user_homedir'], ".ssh")
    directory ssh_dir do
      owner node['zenoss']['client']['local_user_name']
      mode "0700"
      action :create
    end
    
    content = ("# This file managed via Chef. Local changes will be" +
      " lost \n" + pubkey)
    file ::File.join(ssh_dir, "authorized_keys") do
      backup false
      owner node['zenoss']['client']['local_user_name']
      mode "0600"
      content content
      action :create
    end
  end

else
  Chef::Log.debug("Skipping creation of local Zenoss user")
end

# The plan is to use this gem at a later date to enable self registration
chef_gem "zenoss_client" do
  version node['zenoss']['client']['gem_version']
  action :install
end