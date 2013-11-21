#
# Cookbook Name:: ldapknife
# Recipe:: default
#
# Copyright 2011, Gerald L. Hevener, Jr, M.S., Marshall University
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
include_recipe "perl"

case node['platform_family']
  when "rhel"
    include_recipe "yum::epel"
    %w{ perl-IPC-Run perl-version openldap-clients }.each do |perlpkg|
      package perlpkg
    end
      cpan_module "Getopt::Declare" 
  when "debian"
    %w{ libgetopt-declare-perl libipc-run-perl libperl-version-perl ldap-utils }.each do |perlpkg|
      package perlpkg
    end
end

cookbook_file "/usr/local/bin/ldapknife.pl" do
  mode "0755"
  owner "root"
  group "root"
end
