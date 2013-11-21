#
# Cookbook Name:: javamonitor
# Resource:: instance
#
# Author:: Jedrzej Sobanski (<jsobanski@lgi.com>)
#
# Copyright 2013, Liberty Global
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

actions :create, :delete, :stop, :start, :restart
default_action :create

attribute :name, :kind_of			=> String, :required => true, :name_attribute => true
attribute :host, :kind_of			=> String, :required => true
attribute :id, :kind_of				=> Integer
attribute :javamonitor_base_url, :kind_of       => String, :required => true
attribute :javamonitor_password, :kind_of       => String, :required => true

def initialize(*args)
  super
  @action = :create
end
