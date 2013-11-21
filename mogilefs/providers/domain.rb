#
# Cookbook Name:: mogilefs
# Provider:: domain
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
  unless @domain.exists
    Chef::Log.info "[mogilefs_domain] creating domain #{new_resource.domain}"
    connection.create_domain(new_resource.domain)
    new_resource.updated_by_last_action(true)
  end
end

action :delete do
  if @domain.exists
    Chef::Log.info "[mogilefs_domain] deleting domain #{new_resource.domain}"
    connection.delete_domain(new_resource.domain)
    new_resource.updated_by_last_action(true)
  end
end

def load_current_resource
  @domain = Chef::Resource::MogilefsDomain.new(new_resource.name)
  @domain.trackers(new_resource.trackers)
  exists = connection.get_domains.has_key?(new_resource.domain)
  @domain.exists(exists)
end
