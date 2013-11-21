#
# Author:: Steve Craig <support@smashrun.com>
# Cookbook Name:: bitly
# Recipe:: example
#
# Copyright 2013, Smashrun, Inc.
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
# see README.md for Usage

begin
  secret = Chef::EncryptedDataBagItem.load_secret("#{node['bitly']['databag_secret']}")
  bt = Chef::EncryptedDataBagItem.load("#{node['bitly']['databag']}", "#{node['bitly']['user']}", secret)
rescue
end

s = ""
# send chat message
ruby_block "bitly_short_example" do
  block {
      # add {if,unless} idempotence here
      begin
        s = Bit.short(bt["api_key"], bt["id"], 'http://www.smashrun.com')
        Chef::Log.info("'http://www.smashrun.com' shortens to: #{s.short_url}")
      rescue
      end
  }
#  ignore_failure true 
end

# bitly returns:
# s = #<Bitly::V3::Url:0x1015ba0c0 @global_hash="19R8Em8", @aggregate_link=nil, @global_clicks=nil, @long_url="http://www.smashrun.com/", @user_clicks=nil, @user_hash="19R8Em7", @clicks_by_minute=nil, @created_by=nil, @short_url="http://bit.ly/19R8Em7", @new_hash=false, @client=#<Bitly::V3::Client:0x1015f2538 @default_query_opts={:apiKey=>"secret", :login=>"user"}>, @title=nil>
