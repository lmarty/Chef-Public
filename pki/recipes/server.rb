#
# Cookbook Name:: pki
# Recipe:: server
#
# Author:: Sean OMeara <someara@opscode.com>
# Copyright:: 2008-2013, Opscode, Inc.
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


node.set['pki']['server'] = true

include_recipe "pki::server_pki"

#### 
# process requests
#### 
needy_nodes = search(:node, "pki_csr:[* TO *] AND chef_environment:#{node.chef_environment}" )
Chef::Log.info("needy_nodes: #{needy_nodes}")

unless needy_nodes.empty? || needy_nodes.nil? then
  needy_nodes.each do |needy_node|
    needy_node['pki']['csr'].keys.each do |key| 

      # write the CSR to disk
      file "/etc/pki/CA/requests/#{key}.csr" do
        content needy_node['pki']['csr'][:"#{key}"]
      end

      execute "signing request for #{key}" do
          cmd = "openssl x509"
          cmd += " -req"
          cmd += " -CA /etc/pki/CA/certs/ca.crt"
          cmd += " -CAkey /etc/pki/CA/private/ca.key"
          cmd += " -in /etc/pki/CA/requests/#{key}.csr"
          cmd += " -out /etc/pki/CA/certs/#{key}.crt"
          command cmd
      end
    end
  end
end
