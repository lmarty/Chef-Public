#
# Cookbook Name:: aws-cloud-watch-cli-tools
# Recipe:: default 
#
# Copyright (C) 2012 Applicaster LTD
# Authors:
#       Vitaly Gorodetsky <v.gorodetsky@applicaster.com>
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

return unless node[:cloud] && node[:cloud][:provider] == "ec2"

#Load aws credentials from aws data bag
begin
  aws = data_bag_item("aws", node[:aws][:data_bag_item])
rescue
  Chef::Log.fatal("Follow the instractions on http://community.opscode.com/cookbooks/aws to setup aws data bag")
end

include_recipe "java"

package "unzip"

remote_file "/tmp/CloudWatch-2010-08-01.zip" do
  source "http://ec2-downloads.s3.amazonaws.com/CloudWatch-2010-08-01.zip"
  action :create_if_missing
end

execute "unzip /tmp/CloudWatch-2010-08-01.zip -d /usr/local/aws-cw-cli" do
  action :run
  not_if { File.exists?("/usr/local/aws-cw-cli") }
end

execute "mv /usr/local/aws-cw-cli/CloudWatch-*/* /usr/local/aws-cw-cli/; rm -r /usr/local/aws-cw-cli/CloudWatch-*;" do
  action :run
  not_if { File.exists?("/usr/local/aws-cw-cli/README.TXT") }
end

file "/usr/local/aws-cw-cli/aws.txt" do
  content <<-EOS
  AWSAccessKeyId=#{aws['aws_access_key_id']}
  AWSSecretKey=#{aws['aws_secret_access_key']}
  EOS
  mode 0600
  owner "ubuntu"
  group "ubuntu"
end

file "/etc/profile.d/aws-cw-cli.sh" do
  content <<-EOS
  export AWS_CLOUDWATCH_HOME=/usr/local/aws-cw-cli
  export PATH=$PATH:$AWS_CLOUDWATCH_HOME/bin 
  export AWS_CREDENTIAL_FILE=/usr/local/aws-cw-cli/aws.txt
  EOS
  mode 0755
end




