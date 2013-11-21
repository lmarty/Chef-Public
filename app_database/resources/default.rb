#
# Cookbook Name:: app_database
# Resource:: default
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

actions :backup, :configure, :migrate
default_action :configure

attribute :app_name, :kind_of => String, :name_attribute => true

attribute :basepath, :kind_of => String, :required => true
attribute :owner, :kind_of => String, :required => true
attribute :group, :kind_of => String, :default => 'root'

attribute :uri, :kind_of => String, :required => true
attribute :type, :kind_of => String, :default => ''

attribute :username, :kind_of => String, :default => nil
attribute :password, :kind_of => String, :default => nil

attribute :backup_file, :kind_of => String, :default => "backup-%{app_name}-%{date}.%{type}", :required => true

attribute :schema_template, :kind_of => String, :default => "migrate/%{type}.erb"
attribute :schema_version, :kind_of => String, :default => '0.0.1'
