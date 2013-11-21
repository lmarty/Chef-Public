#
# Cookbook Name:: npm_registry
# Recipe:: default
#
# Copyright 2013 Cory Roloff
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
#

node.default['npm_registry']['registry']['url'] = "#{!node['couch_db']['config']['couchdb']['httpsd'] ? 'http' : 'https'}://localhost:#{node['couch_db']['config']['httpd']['port']}"

_npm_registry = node['npm_registry'];
_git = _npm_registry['git']
_couch_db = node['couch_db']
_config = _couch_db['config']
_httpd = _config['httpd']
_couchdb = _config['couchdb']
_daemons = _config['daemons']
_registry = _npm_registry['registry']
_isaacs = _npm_registry['isaacs']
_replication = _npm_registry['replication']
_scheduled = _replication['scheduled']

package 'curl' do
  action :install
end

execute 'killall beam' do
  command 'killall beam'
  returns [0, 1]
  action :run
end

service 'couchdb' do
  action :restart
end

__file_exists = File.exists?("#{((_couchdb['database_dir'] ? Pathname.new(_couchdb['database_dir']).cleanpath() : nil) || '/usr/local/var/lib/couchdb')}/registry.couch")

http_request 'create registry database' do
  url "#{Pathname.new(_registry['url']).cleanpath().to_s().gsub(':/', '://')}/registry"
  not_if { __file_exists }
  action :put
end

log "Created registry database" do
  not_if { __file_exists }
end

git "#{Chef::Config['file_cache_path']}/npmjs.org" do
  repository _git['url']
  reference _git['reference']
  not_if { __file_exists }
  action :sync
end

log "Cloned #{_git['url']}@#{_git['reference']}" do
  not_if { __file_exists }
end

execute 'npm install couchdb -g' do
  command 'npm install couchapp -g'
  cwd "#{Chef::Config['file_cache_path']}/npmjs.org"
  not_if { __file_exists }
  action :run
end

execute 'npm install couchapp' do
  command 'npm install couchapp'
  cwd "#{Chef::Config['file_cache_path']}/npmjs.org"
  not_if { __file_exists }
  action :run
end

execute 'npm install semver' do
  command 'npm install semver'
  cwd "#{Chef::Config['file_cache_path']}/npmjs.org"
  not_if { __file_exists }
  action :run
end

execute 'push.sh' do
  command './push.sh'
  cwd "#{Chef::Config['file_cache_path']}/npmjs.org"
  environment({'npm_package_config_couch' => "#{Pathname.new(_registry['url']).cleanpath().to_s().gsub(':/', '://')}/registry"})
  not_if { __file_exists }
  action :run
end

execute 'load-views.sh' do
  command './load-views.sh'
  cwd "#{Chef::Config[:file_cache_path]}/npmjs.org"
  environment({'npm_package_config_couch' => "#{Pathname.new(_registry['url']).cleanpath().to_s().gsub(':/', '://')}/registry"})
  not_if { __file_exists }
  action :run
end

bash 'COPY _design/app' do
  code <<-EOH
    curl #{"#{Pathname.new(_registry['url']).cleanpath().to_s().gsub(':/', '://')}/registry"}/_design/scratch -X COPY -H destination:'_design/app'
  EOH
  not_if { __file_exists }
end

execute "couchapp push www/app.js #{"#{Pathname.new(_registry['url']).cleanpath().to_s().gsub(':/', '://')}/registry"}" do
  command "couchapp push www/app.js #{"#{Pathname.new(_registry['url']).cleanpath().to_s().gsub(':/', '://')}/registry"}"
  cwd "#{Chef::Config['file_cache_path']}/npmjs.org"
  not_if { __file_exists }
  action :run
end

case _replication['flavor']
when 'scheduled'
  cron_d 'npm_registry' do
    action :create
    minute _scheduled['minute']
    hour _scheduled['hour']
    weekday _scheduled['weekday']
    day _scheduled['day']
    command %Q{curl -X POST -H "Content-Type:application/json" #{Pathname.new(_registry['url']).cleanpath().to_s().gsub(':/', '://')}/_replicate -d '{"source":"#{Pathname.new(_isaacs['registry']['url']).cleanpath().to_s().gsub(':/', '://')}/", "target":"registry"}'}
  end

  log "Configured scheduled replication"
when 'continuous'
  http_request 'npm_registry' do
    url "#{Pathname.new(_registry['url']).cleanpath().to_s().gsub(':/', '://')}/_replicate"
    action :post
    headers(
      'Content-Type' => 'application/json'
    )
    message(
      :source => "#{Pathname.new(_isaacs['registry']['url']).cleanpath().to_s().gsub(':/', '://')}/",
      :target => "registry",
      :continuous => true
    )
  end

  log 'Configured continuous replication'
else
  log "Skipping replication"
end