#
# Chef Cookbook   : netdev
# File            : resources/interface.rb
#    
# Copyright 2013 Arista Networks
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

actions :create, :delete
default_action :create

attribute :name,          :kind_of => String, :name_attribute => true, :required => true
attribute :admin,         :kind_of => String, :equal_to => ['up', 'down']
attribute :description,   :kind_of => String
attribute :mtu,           :kind_of => Integer
attribute :speed,         :kind_of => String, :equal_to => ['auto', '100m', '1g', '10g']
attribute :duplex,        :kind_of => String, :equal_to => ['auto', 'half', 'full']
attribute :active,        :kind_of => [TrueClass, FalseClass], :default => true

attr_accessor :exists

