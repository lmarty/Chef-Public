#
# Cookbook Name:: pki
# Recipe:: server_pki
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

# Common packages
package "openssl"
package "rsync"
package "xinetd"

# create CA if one does not exist
pki_selfsignedca "ca" do
  action [:create]
end

# make a directory to place requests in
directory "/etc/pki/CA/requests" do
  action [:create]
  owner "root"
  mode 0700
end

# rsync xinetd configuration
template "/etc/xinetd.d/rsync" do
  source "rsync.xinetd.erb"
  notifies :restart, "service[xinetd]"
end

# rsyncd config
template "/etc/rsyncd.conf" do
  source "rsyncd.conf.erb"
end

# ensure xinetd is running
service "xinetd" do
  action [:enable,:start]
end

#### 
# create self client certificates.
#### 

# key
execute "generate private key" do
  Chef::Log.info("creating servercert private key for #{node['fqdn']}")
  command "/usr/bin/openssl genrsa -out /etc/pki/tls/private/#{node['fqdn']}.key 2048"
  not_if "/usr/bin/test -f /etc/pki/tls/private/#{node['fqdn']}.key"
#end.run_action(:run)
end

# If key but no cert, generate CSR
execute "generating CSR" do
  Chef::Log.info("generating certificate request")
  cmd = "/usr/bin/openssl req"
  cmd += " -new"
  cmd += " -nodes"
  cmd += " -subj '/CN=#{node['fqdn']}/'"
  cmd += " -key /etc/pki/tls/private/#{node['fqdn']}.key"
  cmd += " -out /etc/pki/tls/private/#{node['fqdn']}.csr"
  command cmd
  not_if  "/usr/bin/test -f/etc/pki/tls/private/#{node['fqdn']}.csr"
  only_if "/usr/bin/test /etc/pki/tls/private/#{node['fqdn']}.key"
end

# Copy the request into the CA
execute "copy server's request into the CA" do
  command "/bin/cp /etc/pki/tls/private/#{node['fqdn']}.csr /etc/pki/CA/requests/#{node['fqdn']}.csr"
  only_if "/usr/bin/test -f /etc/pki/tls/private/#{node['fqdn']}.csr"
  not_if  "/usr/bin/test -f /etc/pki/CA/requests/#{node['fqdn']}.csr"
end

# sign the certificate request.
execute "signing the server's certificate request" do
  cmd = "/usr/bin/openssl x509"
  cmd += " -req"
  cmd += " -CA /etc/pki/CA/certs/ca.crt"
  cmd += " -CAkey /etc/pki/CA/private/ca.key"
  cmd += " -in /etc/pki/CA/requests/#{node['fqdn']}.csr"
  cmd += " -out /etc/pki/CA/certs/#{node['fqdn']}.crt"
  command cmd
  not_if  "/usr/bin/test -f /etc/pki/tls/private/#{node['fqdn']}.crt"
  only_if "/usr/bin/test -f /etc/pki/CA/requests/#{node['fqdn']}.csr"
end

# Ship it.
execute "copy the server's certificate from the CA into the tls dir" do
  command "/bin/cp /etc/pki/CA/certs/#{node['fqdn']}.crt /etc/pki/tls/private/#{node['fqdn']}.crt"
  only_if "/usr/bin/test -f /etc/pki/CA/certs/#{node['fqdn']}.crt"
  not_if  "/usr/bin/test -f /etc/pki/tls/private/#{node['fqdn']}.crt"
end

