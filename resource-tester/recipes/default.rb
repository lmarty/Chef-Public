#
# Cookbook Name:: resource-tester
# Recipe:: default
# Author:: Sean OMeara <someara@opscode.com>
# Copyright 2012, Opscode
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

include_recipe "minitest-handler"

####################
# user resource
####################

user 'kermit'

user 'fonzi user' do
  username 'fonzi'
  comment 'wokka wokka'
  uid '1234'
  home '/home/fonzi'
end

####################
# group resource
####################
group 'muppets'

group 'transformers groups' do
  group_name 'transformers'
end

#####################
# directory resources
#####################

directory "/tmp/foo"

directory 'tmp foo bar' do
  path '/tmp/foo/bar'
  owner 'kermit'
  group 'muppets'
end

directory '/tmp/foo/bar/baz/biz' do
  owner 'fonzi'
  group 'transformers'
  recursive true
end

####################
# file resources
####################
file '/tmp/foofile'

file '/tmp/foofile2' do
  content 'hello'
  owner 'kermit'
  group 'muppets'
  mode '0624'
end

####################
# template resource
####################

# This should find a source file in templates/default/templatefile1.erb
template '/tmp/tempfile1'

template '/tmp/tempfile2' do
  source 'tempfile2.erb'
  owner 'kermit'
  group 'muppets'
  mode '0624'
end

template '/tmp/tempfile3' do
  source 'tempfile3.erb'
  owner 'kermit'
  group 'muppets'
  variables(:hello => 'world')
  mode '624'
end

# http://tickets.opscode.com/browse/CHEF-174
template '/tmp/tempfile4' do
  source 'tempfile3.erb'
  owner 'kermit'
  group 'muppets'
  variables(:hello => 'world')
  mode 00624
end

#########################
# cookbook_file resources
#########################

cookbook_file '/tmp/cookbook_spacer.gif' do
  source 'spacer.gif'
  owner 'kermit'
  group 'muppets'
  mode '0624'
end

#######################
# remote_file resources
#######################

remote_file '/tmp/http_spacer.gif' do
  source 'http://www.opscode.com/images/spacer.gif'
  owner 'kermit'
  group 'muppets'
  mode '0624'
end

############################
# remote_directory resources
############################

remote_directory '/tmp/der' do
  source 'der'
  owner 'kermit'
  group 'muppets'
  mode '0715'
  files_owner 'fonzi'
  files_group 'muppets'
  files_mode '0624'
end

############################
# cron resources
############################

cron 'noop-5' do
  hour '5'
  minute '0'
  command '/bin/true'
end

cron 'noop-10' do
  hour '10'
  minute '5'
  command '/bin/true'
end

cron 'noop-20' do
  hour '20'
  minute '5'
  command '/bin/true'
  user 'fonzi'
end

############################
# package resources
############################

# something already installed
package 'coreutils'

package 'nmap' do
  action :install
end

############################
# service resources
############################

