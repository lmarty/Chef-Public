#
# Author:: Michael Hodgdon <mhodgdon@citytechinc.com>
# Author:: Christian Vozar <cvozar@citytechinc.com>
# Cookbook Name:: AmazonEC2Tag
# Recipe:: default
#
# Copyright 2011, CITYTECH, Inc.
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

# An example data bag where AWS EC2 credentials are fetched from the data bag.
aws_properties = data_bag_item('aws_credentials', 'AmazonEC2')

# The included library requires the aws-sdk Ruby gem.
r = gem_package "aws-sdk" do
  action :nothing
end

r.run_action(:install)

require 'rubygems'
Gem.clear_paths # Reload currently installed Ruby gems.
require 'aws-sdk'

# This is an example AWS EC2 Tag.
# Change "tag_key" to the Tag name you wish to change.
# Change "tag_value" to the text you wish to associate the "tag_key".
# Ensure that aws_access_key and aws_secret_access_key are set. Ideally from an encrypted data bag.
AmazonEC2_ec2tag "tag_key" do
  aws_access_key aws_properties["amazon-ec2"]["access_key"]
  aws_secret_access_key aws_properties["amazon-ec2"]["private_key"]
  value "tag_value"
  instance_id node["ec2"]["instance_id"] # This will set the tag to the current node instance ID.
  action :create
end