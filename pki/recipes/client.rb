#
# Cookbook Name:: pki
# Recipe:: client
#
# Author:: Sean OMeara <someara@opscode.com>
#
# Copyright 2008-2013, Opscode, Inc
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


Chef::Log.info("Entering pki::client")

node.set['pki']['client'] = true
pki_servers = search(:node, "pki_server:true AND chef_environment:#{node.chef_environment}")

unless pki_servers.empty?
  package "openssl"
  package "rsync"

  # write ca cert to disk
  file "#{node['pki']['openssldir']}/certs/ca.crt" do
    content pki_servers[0]['pki']['cacert']
    owner "root"
    group "root"
  end.run_action(:create)

  cacert_hash = `openssl x509 -noout -hash -in #{node['pki']['openssldir']}/certs/ca.crt`

  # create symlink to cert
  link "#{node['pki']['openssldir']}/certs/#{cacert_hash.chomp}.0" do
    to "#{node['pki']['openssldir']}/certs/ca.crt" 
  end
    
  # request a server certificate for the node
  pki_servercert "#{node['fqdn']}" do
    action [:create]
    pkiserver pki_servers[0]['fqdn']
  end
end
