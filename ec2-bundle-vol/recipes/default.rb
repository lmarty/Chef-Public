#
# Cookbook Name:: ec2-bundle-vol
# Recipe:: default
#
# Copyright 2011, trampoline systems ltd
#
# All rights reserved - Do Not Redistribute
#
require 'time'

aws_account = node[:aws_account]
aws_auth = data_bag_item('aws', aws_account)

ami_upload = node[:ami_upload]
t = Time.now.utc
bucket = "#{ami_upload["bucket_base"]}/#{t.year}#{t.month}#{t.day}-#{t.hour}#{t.min}"

aws_instance_type = node[:ec2][:instance_type]
aws_arch = aws_instance_type == "m1.small" ? "i386" : "x86_64"

ruby_block "write_key_and_cert" do
  block do
    File.open("/tmp/aws_private_key.pem", "w") do |io|
      io << aws_auth["private_key"]
    end
    File.open("/tmp/aws_cert.pem", "w") do |io|
      io << aws_auth["certificate"]
    end
  end
end

bash "bundle_image" do
  code <<-EOH
    export EC2_AMITOOL_HOME=/usr/local/share/ec2-ami-tools    
    $EC2_AMITOOL_HOME/bin/ec2-bundle-vol -c /tmp/aws_cert.pem -k /tmp/aws_private_key.pem -u #{aws_auth["account_number"]} -r #{aws_arch} -s 1000 -d /mnt
    $EC2_AMITOOL_HOME/bin/ec2-upload-bundle -m /mnt/image.manifest.xml -a #{aws_auth["access_key"]} -s #{aws_auth["secret_access_key"]} --location #{ami_upload["location"]} -b #{bucket}
  EOH
  not_if {File.exist?("/mnt/image.manifest.xml")}
end
