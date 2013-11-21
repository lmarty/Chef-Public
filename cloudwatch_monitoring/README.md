cloudwatch_monitoring
==========

Install Amazon AWS Cloud Watch Monitoring Scripts

Cloudwatch_monitoring: The Amazon CloudWatch Monitoring Scripts for Linux are sample Perl scripts that
demonstrate how to produce and consume Amazon CloudWatch custom metrics.

The scripts comprise a fully functional example that reports memory, swap, and disk space utilization metrics
for an Amazon Elastic Compute Cloud (Amazon EC2) Linux instance.


http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/mon-scripts-perl.html


Requirements
==========

## Platform:

* Ubuntu/Debian


Attributes
==========

* `node[:cw_mon][:user]` - the user to run the script as. Created if necessary. Defaults to `cw_monitoring`.
* `node[:cw_mon][:group]` - the group the files should belong to. Defaults to `cw_monitoring`.
* `node[:cw_mon][:home_dir]` - the directory to install the scripts in. Defaults to  `/home/#{node[:cw_mon][:user]}`
* `node[:cw_mon][:version]`  - the version of the scripts to install. Defaults to `1.1.0`
* `node[:cw_mon][:release_url]` - the URL to download from. Defaults to `http://ec2-downloads.s3.amazonaws.com/cloudwatch-samples/CloudWatchMonitoringScripts-v1.1.0.zip`
* `node[:cw_mon][:aws_users_databag]` - the encrypted databag containing the AWS key. See section below for details. Defaults to `aws_users`
* `node[:cw_mon][:access_key_id]`     - the AWS access key id the script should authenticate with. See section below for details.
* `node[:cw_mon][:secret_access_key]` - the AWS access key the script should authenticate with. See section below for details.
* `node[:cw_mon][:options]` - the list of options to pass to the script. By default, all options are included:
            `--disk-space-util  --disk-path=/ --disk-space-used --disk-space-avail`
             `--swap-util --swap-used --mem-util --mem-used --mem-avail`


Usage
=====

Put `recipe[cloudwatch_monitoring]` in a run list, or `include_recipe 'cloud_watch_monitoring'` to ensure that
the CloudWatch script is installed and cron'ed on your systems.

## AWS authentication

### with IAM role (recommended)

If your instance has an IAM role, then the script will use it to and you don't have to worry about setting keys.

Make sure that the role has permissions to perform the Amazon CloudWatch `PutMetricData` operation.


### with a key

If your instance does not have a role, you need to specify a key. This can be done in 2 ways:

1. using the encrypted data bad specified by `node[:cw_mon][:aws_users_databag]`.  That bag must contain an item for `node[:cw_mon][:user]` with 2 attributes: `access_key_id` and `secret_access_key`
2. using the node attributes: `node[:cw_mon][:secret_access_key]` and `node[:cw_mon][:secret_access_key]`

If the key get be loaded from the databag, the node attributes will be used.

Make sure that the user associated to the key has permissions to perform the Amazon CloudWatch `PutMetricData` operation.



Changes
=======

## v1.0.0:

License and Author
==================

Author:: Alexis Midon <alexismidon@gmail.com>

Copyright 2013, Alexis Midon

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
