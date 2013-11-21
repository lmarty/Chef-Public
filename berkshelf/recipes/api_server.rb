#
# Cookbook Name:: berkshelf
# Recipe:: api_server
#
# Copyright (C) 2013 Jamie Winsor
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

include_recipe "berkshelf::_common"

case node[:berkshelf][:api][:install_method].to_sym
when :gem
  rbenv_gem "berkshelf-api" do
    version node[:berkshelf][:api][:version]
    ruby_version node[:berkshelf][:ruby_version]
    notifies :restart, "runit_service[berks-api]"
  end
when :git
  node.set[:berkshelf][:api][:bin_path] = "/opt/berkshelf-api/bin/berks-api"

  git "/opt/berkshelf-api" do
    repository node[:berkshelf][:api][:git_repo]
    revision node[:berkshelf][:api][:git_revision]
    notifies :run, "execute[berks-api-bundle-update]"
    notifies :restart, "runit_service[berks-api]"
  end

  rbenv_gem "bundler" do
    ruby_version node[:berkshelf][:ruby_version]
  end

  execute "berks-api-bundle-install" do
    cwd "/opt/berkshelf-api"
    environment "RBENV_ROOT" => "/opt/rbenv"
    command "bundle install"
    not_if { ::File.exist?("/opt/berkshelf-api/Gemfile.lock") }
  end

  execute "berks-api-bundle-update" do
    cwd "/opt/berkshelf-api"
    environment "RBENV_ROOT" => "/opt/rbenv"
    command "bundle update"
    action :nothing
  end
else
  Chef::Application.fatal!("[berkshelf::api_server] unknown install method: #{node[:berkshelf][:api][:install_method]}")
end

directory node[:berkshelf][:api][:home]

file node[:berkshelf][:api][:config_path] do
  content JSON.generate(node[:berkshelf][:api][:config])
end

include_recipe "runit"

package "libarchive12"
package "libarchive-dev"

runit_service "berks-api"
