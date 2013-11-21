#
# Cookbook Name:: media
# Recipe:: setup_nfs_shares
#
# Copyright (C) 2013 Kannan Manickam
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
#

# Setup the NFS server
include_recipe "nfs::server"

# Setup the exports entry for each NFS share
node['media']['nfs']['shares'].each do |nfs_share|
  nfs_export nfs_share do
    network node['media']['nfs']['network']
    writeable node['media']['nfs']['writable']
    sync node['media']['nfs']['sync']
    options node['media']['nfs']['options']
    notifies :restart, "service[#{node['nfs']['service']['server']}]"
  end
end
