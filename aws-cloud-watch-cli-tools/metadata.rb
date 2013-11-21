name             "aws-cloud-watch-cli-tools"
maintainer       "Applicaster LTD"
maintainer_email "technical@applicaster.com"
license          "Apache 2.0"
description      "Installs and configures AWS CloudWatch cli tools"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2"

recipe "aws-cloud-watch-cli-tools", "Installs AWS CloudWatch Command Line Tools"
recipe "aws-cloud-watch-cli-tools::ec2-write-memory-metrics", "Adds memory metrics reporting to CloudWatch"

depends 'aws',   '>= 0.100.6'
depends 'java', '>= 1.8.0'

%w{ ubuntu debian}.each do |os|
  supports os
end