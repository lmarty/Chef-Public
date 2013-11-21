#
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: nephele
# Recipe:: nephele
#
# Copyright 2012, Smashrun, Inc.
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

log("begin nephele.rb") { level :debug }
log("running nephele.rb") { level :info }

log("create chef tmp directory if necessary") { level :debug }
directory "#{node[:nephele][:tempdir]}" do
  action :create
  not_if { File.exists?("#{node[:nephele][:tempdir]}") }
  recursive true
end

node[:nephele][:gem].each do |g|
  gem_package("#{g[:name]}") do
    action :install
  end
end



log("end nephele.rb") { level :info }
