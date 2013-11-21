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

require_relative './test_helper'

def user_name(node)
  return node['zenoss']['client']['local_user_name']
end

describe_recipe 'zenoss_client::default' do
  include Zenoss::Client::Test::Helper
  MiniTest::Chef::Resources.register_resource(:chef_gem)
  describe "users" do
    it "creates a local zenoss user when requested" do
      skip "Local user creation disabled" unless node['zenoss']['client']['create_local_user'] == true

      user(user_name(node)).must_exist.with(:comment, node['zenoss']['client']['local_user_comment'])
    end
    
    it "sets the applicable properties on the local zenoss user" do
      skip "Attributes not supported on Windows" if node['os'] == "windows"
      skip "Local user creation disabled" unless node['zenoss']['client']['create_local_user'] == true
      
      user(user_name(node)).must_exist.with(:home, node['zenoss']['client']['local_user_homedir'])
      user(user_name(node)).must_exist.with(:shell, node['zenoss']['client']['local_user_shell'])
    end
  end
  
  describe "files and directories" do
    it "creates the zenoss user's ssh authorized_keys file" do
      skip "Local user creation disabled" unless node['zenoss']['client']['create_local_user'] == true
      authorized_keys_file = ::File.join(
        node['zenoss']['client']['local_user_homedir'], 
        ".ssh",
        "authorized_keys"
      )
      file(authorized_keys_file).must_exist.with(:mode, "0600") 
      file(authorized_keys_file).must_exist.with(:owner, user_name(node))
      file(authorized_keys_file).must_include('Chef')
    end
  end
  
  describe "gems" do
    it "installs the requested zenoss_client gem version"  do
      version = node['zenoss']['client']['gem_version']
      chef_gem("zenoss_client").must_be_installed.with(:version, version)
    end
  end
end