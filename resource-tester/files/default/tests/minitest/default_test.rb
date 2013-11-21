#
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

require 'minitest/spec'

describe_recipe 'resource-tester::default' do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  #####################
  # user resources
  #####################
  it 'creates a user resource named kermit' do
    user('kermit').must_exist
  end

  describe 'creates a user named fonzi with comment, uid, and home customized' do
    let(:testuser) { user('fonzi') }
    it { testuser.must_exist }
    it { testuser.must_have(:username, 'fonzi') }
    it { testuser.must_have(:comment, 'wokka wokka') }
    it { testuser.must_have(:uid, 1234) }
    it { testuser.must_have(:home, '/home/fonzi') }
  end
  
  #####################
  # group resources
  #####################
  it 'creates a group named muppets' do
    group('muppets').must_exist
  end

  it 'creates a group named muppets with group_name specified' do
    group('transformers').must_exist.with(:group_name, 'transformers')
  end

  #####################
  # directory resources
  #####################
  it 'creates a directory named /tmp/foo' do
    directory('/tmp/foo').must_exist
  end

  describe 'creates directory named /tmp/foo/bar with owner and group' do
    let(:testfile) { directory('/tmp/foo/bar') }
    it { testfile.must_exist }
    it { testfile.must_have(:owner, 'kermit') }
    it { testfile.must_have(:group, 'muppets') }
  end

  describe 'creates directory /tmp/foo/bar/baz/biz recursively with owner and group' do
    let(:testfile) { directory('/tmp/foo/bar/baz/biz') }
    it { testfile.must_exist }
    it { testfile.must_have(:owner, 'fonzi') }
    it { testfile.must_have(:group, 'transformers') }
  end

  #####################
  # file resources
  #####################
  it 'creates /tmp/foofile' do
    file('/tmp/foofile').must_exist
  end

  describe 'foofile2 with content hello, owner kermit, and group muppets' do
    let(:testfile) { file('/tmp/foofile2') }
    it { testfile.must_have(:owner, 'kermit') }
    it { testfile.must_have(:group, 'muppets') }
    it { testfile.must_include('hello') }
  end

  #####################
  # template resources
  #####################
  it 'creates /tmp/tempfile1' do
    file('/tmp/tempfile1').must_exist
  end

  describe 'tmpfile2 - render template' do
    let(:testfile) { file('/tmp/tempfile2') }
    it { testfile.must_have(:owner, 'kermit') }
    it { testfile.must_have(:group, 'muppets') }
    it { testfile.must_have(:mode, "624") }  # minitest bug? can't set '0624'
    it { testfile.must_match(/^# I am tempfile2.erb$/) }
  end

  describe 'tmpfile3 - pass in variables' do
    let(:testfile) { file('/tmp/tempfile3') }
    it { testfile.must_have(:owner, 'kermit') }
    it { testfile.must_have(:group, 'muppets') }
    it { testfile.must_have(:mode, "624") }  # minitest bug? can't set '0624'
    it { testfile.must_match(/^# hello world$/) }
  end


  describe 'tmpfile4 - octal permissions' do
    let(:testfile) { file('/tmp/tempfile3') }
    it { testfile.must_have(:owner, 'kermit') }
    it { testfile.must_have(:group, 'muppets') }
    it { testfile.must_have(:mode, "624") }  # minitest bug? can't set '0624'
    it { testfile.must_match(/^# hello world$/) }
  end

  #########################
  # cookbook_file resources
  #########################
  
  describe 'cookbook_file /tmp/cookbook_spacer.gif with owner group and mode' do
    let(:testfile) { file('/tmp/cookbook_spacer.gif') }
    it { testfile.must_have(:owner, 'kermit') }
    it { testfile.must_have(:group, 'muppets') }
    it { testfile.must_have(:mode, "624") }  # minitest bug? can't set '0624'
  end

  #######################
  # remote_file resources
  #######################

  describe 'remote_file /tmp/http_spacer.gif with owner group and mode' do
    let(:testfile) { file('/tmp/http_spacer.gif') }
    it { testfile.must_have(:owner, 'kermit') }
    it { testfile.must_have(:group, 'muppets') }
    it { testfile.must_have(:mode, "624") }  # minitest bug? can't set '0624'
  end

  ############################
  # remote_directory resources
  ############################

  describe 'remote_directory /tmp/der with owner group and perms' do
    let(:testdir) { directory('/tmp/der') }
    let(:testfile1) { file('/tmp/der/pde/rpd/erp/derp1.gif') }
    let(:testfile2) { file('/tmp/der/pde/rpd/erp/derp2.gif') }
    let(:testfile3) { file('/tmp/der/pde/rpd/erp/derp3.gif') }
    it { testdir.must_have(:owner, 'kermit') }
    it { testdir.must_have(:mode, '715') }
    
    it { testfile1.must_have(:owner, 'fonzi') }
    it { testfile1.must_have(:group, 'muppets') }
    it { testfile1.must_have(:mode, '624') } # test in octal?

    it { testfile2.must_have(:owner, 'fonzi') }
    it { testfile2.must_have(:group, 'muppets') }
    it { testfile2.must_have(:mode, '624') } # test in octal?
    
    it { testfile3.must_have(:owner, 'fonzi') }
    it { testfile3.must_have(:group, 'muppets') }
    it { testfile3.must_have(:mode, '624') } # test in octal?
  end

  ############################
  # cron resources
  ############################

  describe 'cron noop-5 with hours 5 min 0 command string' do
    let(:testfile) { file('/var/spool/cron/root') }
    it { testfile.must_exist }
    it { testfile.must_have(:owner, 'root') }
    it { testfile.must_have(:mode, '600') }
    it { testfile.must_include('0 5 * * * /bin/true') }
  end
  
  describe 'cron noop-10 with hours 10 min 5 command string' do
    let(:testfile) { file('/var/spool/cron/root') }
    it { testfile.must_exist }
    it { testfile.must_have(:owner, 'root') }
    it { testfile.must_have(:mode, '600') }
    it { testfile.must_include('5 10 * * * /bin/true') }
  end
  
  describe 'cron noop-20 with hours 20 min 5 command string user fonzi' do
    let(:testfile) { file('/var/spool/cron/fonzi') }
    it { testfile.must_exist }
    it { testfile.must_have(:owner, 'root') }
    it { testfile.must_have(:mode, '600') }
    it { testfile.must_include('5 20 * * * /bin/true') }
  end

  ############################
  # package resources
  ############################

  
  
end
