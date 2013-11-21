#
# Cookbook Name:: rsdns
# Recipe:: default
#
# Copyright 2012, Rackspace Hosting
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

#Install git
case node[:platform]
when "debian", "ubuntu"
  package "git-core"
else
  package "git"
end

#Install the rsdns tools from github
script "install rsdns" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    git clone https://github.com/linickx/rsdns.git /opt/rsdns
  EOH
  not_if "test -f /opt/rsdns/rsdns"
end

link "/usr/local/bin/rsdns" do
  to "/opt/rsdns/rsdns"
end

if Chef::DataBag.list.keys.include?("rackspace") && data_bag("rackspace").include?("cloud")
  #Access the Rackspace Cloud encrypted data_bag
  raxcloud = Chef::EncryptedDataBagItem.load("rackspace","cloud")

  #Create variables for the Rackspace Cloud username and apikey
  raxusername = raxcloud['raxusername']
  raxapikey = raxcloud['raxapikey']
else
        Chef::Log.info "rackspace data bag with item cloud does not exist, skip adding user and api to ./root/rsdns_config"
end

#Create the .raxrc with credentials in /root
template "/root/.rsdns_config" do
  source "rsdns_config.erb"
  owner "root"
  group "root"
  mode 0640
  variables(
    :raxusername => raxusername,
    :raxapikey => raxapikey
  )
end
