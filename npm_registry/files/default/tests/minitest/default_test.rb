#
# Cookbook Name:: npm_registry
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

require 'minitest/spec'
require File.expand_path('../support/helpers', __FILE__)

sleep(5)

describe_recipe 'npm_registry::default' do
  include Helpers::NPM_Registry

  it 'should query the registry database endpoints' do
    assert_equal JSON.parse(Net::HTTP.get(URI.parse('http://localhost:5984/registry')))['db_name'], 'registry'
    assert_equal JSON.parse(Net::HTTP.get(URI.parse('http://localhost:5984/registry/_design/app')))['_id'], '_design/app'
    assert_equal JSON.parse(Net::HTTP.get(URI.parse('http://localhost:5984/registry/_design/ghost')))['_id'], '_design/ghost'
    assert_equal JSON.parse(Net::HTTP.get(URI.parse('http://localhost:5984/registry/_design/scratch')))['_id'], '_design/scratch'
    assert_equal JSON.parse(Net::HTTP.get(URI.parse('http://localhost:5984/registry/_design/ui')))['_id'], '_design/ui'
  end
end