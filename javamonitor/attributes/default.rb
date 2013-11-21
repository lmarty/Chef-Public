# Cookbook Name:: javamonitor
# Attributes:: default
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

include_attribute "webobjects"

default[:javamonitor][:base_url] = "http://#{node[:webobjects][:webobjects_JavaMonitor_host]}:#{node[:webobjects][:webobjects_JavaMonitor_port]}/cgi-bin/WebObjects/JavaMonitor.woa"
default[:javamonitor][:password] = node[:webobjects][:webobjects_JavaMonitor_password]
default[:javamonitor][:output_path] = node[:webobjects][:webobjects_WOLog_dir]
