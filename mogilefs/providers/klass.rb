#
# Cookbook Name:: mogilefs
# Provider:: klass
#
# Author:: Jamie Winsor (<jamie@enmasse.com>)
#
# Copyright 2011, En Masse Entertainment, Inc.
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

include EnMasse::MogileFS::Admin

action :create do
  unless @klass.exists
    Chef::Log.info "[mogilefs_klass] creating class #{new_resource.klass}"
    connection.create_class(new_resource.domain, new_resource.klass, new_resource.mindevcount)
    new_resource.updated_by_last_action(true)
  end
end

action :delete do
  if @klass.exists
    Chef::Log.info "[mogilefs_klass] deleting class #{new_resource.klass}"
    connection.delete_class(new_resource.domain, new_resource.klass)
    new_resource.updated_by_last_action(true)
  end
end

action :update do
  if @klass.exists
    Chef::Log.info "[mogilefs_klass] updating class #{new_resource.klass}"
    connection.update_class(new_resource.domain, new_resource.klass, new_resource.mindevcount)
    new_resource.updated_by_last_action(true)
  end
end

def load_current_resource
  @klass = Chef::Resource::MogilefsKlass.new(new_resource.name)
  @klass.trackers(new_resource.trackers)
  exists = connection.get_domains.has_key?(new_resource.domain) &&
    connection.get_domains[new_resource.domain].has_key?(new_resource.name)
  @klass.exists(exists)
end
