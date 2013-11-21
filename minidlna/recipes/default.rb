#
# Cookbook Name:: minidlna
# Recipe:: default
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

# Install the minidlna package
package "minidlna"

# Make sure that the database directory exists
directory node['minidlna']['db_dir'] do
  recursive true
  owner "minidlna"
  group "minidlna"
  mode 0755
end

# Enable and start the minidlna service
service "minidlna" do
  action [:enable, :start]
end

# The files.db file
db_file = "#{node['minidlna']['db_dir']}/files.db"

# The file resource for performing the deletion of the file for reloading the
# database for newly added media directories.
file db_file do
  backup false
  action :nothing
end

# The minidlna configuration
template "/etc/minidlna.conf" do
  source "minidlna.conf.erb"
  mode 0644
  owner "minidlna"
  group "minidlna"
  variables :conf => node['minidlna']
  notifies :delete, "file[#{db_file}]"
  notifies :restart, "service[minidlna]"
end
