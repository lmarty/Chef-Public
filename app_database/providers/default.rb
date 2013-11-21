#
# Cookbook Name:: app_database
# Provider:: default
#
# Author:: BinaryBabel OSS (<projects@binarybabel.org>)
# Homepage:: http://www.binarybabel.org
# License:: Apache License, Version 2.0
#
# For bugs, docs, updates:
#
#     http://code.binbab.org
#
# Copyright 2013 sha1(OWNER) = df334a7237f10846a0ca302bd323e35ee1463931
#  
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#  
#     http://www.apache.org/licenses/LICENSE-2.0
#  
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'uri'

def initialize(new_resource, run_context)
  super

  if new_resource.group.empty?
    new_resource.group(new_resource.owner)
  end

  if new_resource.type.empty?
    uri = URI(new_resource.uri)
    raise ArgumentError, "Could not parse database URI. (#{uri})" unless uri
    new_resource.type(uri.scheme)
  end

  sub_provider_name = "app_database_#{new_resource.type}".to_sym
  sub_provider_class = new_resource.send(:lookup_provider_constant, sub_provider_name)
  @sub_provider = sub_provider_class.new(new_resource, run_context)
end

[ :backup, :configure, :migrate ].each do |a|

  action a do
    @sub_provider.run_action(a)
  end

end
