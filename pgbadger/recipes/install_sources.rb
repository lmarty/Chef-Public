#
# Cookbook Name:: pgbadger
# Recipe:: install_sources
# Author:: Guilhem Lettron <guilhem.lettron@youscribe.com>
#
# Copyright 2012, Societe Publica.
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

case node['pgbadger']['source']
when "tarball"
  remote_file "#{Chef::Config[:file_cache_path]}/pgbadger-#{node['pgbadger']['version']}.tar.gz" do
    source "https://github.com/downloads/dalibo/pgbadger/pgbadger-#{node['pgbadger']['version']}.tar.gz"
    notifies :run, "bash[extract_tarball]"
  end
  bash "extract_tarball" do
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
      tar zxf pgbadger-#{node['pgbadger']['version']}.tar.gz -C pgbadger-tarball
    EOH
    action :nothing
    notifies :run, "bash[compile_pgbadger]"
  end
  link "#{Chef::Config[:file_cache_path]}/pgbadger" do
    to "#{Chef::Config[:file_cache_path]}/pgbadger-tarball"
  end
when "github"
  include_recipe "git"
  git "#{Chef::Config[:file_cache_path]}/pgbadger-git" do
    repository "git://github.com/dalibo/pgbadger.git"
    reference "master"
    action :sync
    notifies :run, "bash[compile_pgbadger]"
  end
  link "#{Chef::Config[:file_cache_path]}/pgbadger" do
    to "#{Chef::Config[:file_cache_path]}/pgbadger-git"
  end
end

include_recipe "perl"

bash "compile_pgbadger" do
  cwd "#{Chef::Config[:file_cache_path]}/pgbadger"
  code "perl Makefile.PL && make"
  action :nothing
  notifies :run, "bash[install_pgbadger]"
end

bash "install_pgbadger" do
  cwd "#{Chef::Config[:file_cache_path]}/pgbadger"
  code "make install"
  action :nothing
end
