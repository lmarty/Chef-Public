#
# Author:: Thorsten Klein (<cookbooks@perlwizard.de>)
# Cookbook Name:: heidisql
# Attribute:: default
#
# Copyright:: Copyright (c) 2013 Thorsten Klein
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

default[:heidisql][:url]          = "http://heidisql.googlecode.com/files/HeidiSQL_7.0_Setup.exe"
default[:heidisql][:checksum]     = "7a21a81eda6fa6761ff7c60de19386620d845f2d69d25c800be6fe8472a9b7ac"
default[:heidisql][:package_name] = "HeidiSQL 7.0.0.4053"

default[:heidisql][:home]    = "#{ENV['SYSTEMDRIVE']}\\HeidiSQL"
