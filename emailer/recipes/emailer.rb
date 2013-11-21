#
# Author:: Steven Craig <support@smashrun.com>
# Cookbook Name:: emailer
# Recipe:: emailer
#
# Copyright 2010, Smashrun, Inc.
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

log("begin emailer.rb") { level :debug }
log("running emailer.rb") { level :info }

log("create chef tmp directory if necessary") { level :debug }
directory "#{node[:emailer][:tempdir]}" do
  action :create
  not_if { File.exists?("#{node[:emailer][:tempdir]}") }
  recursive true
end

gem_package("mail") do
  options(:version => "#{node[:emailer][:version]}", :prerelease => false, :format_executable => false)
end

gem_package("ruby-debug") do
  options(:prerelease => false, :format_executable => false)
end

log("end emailer.rb") { level :info }
