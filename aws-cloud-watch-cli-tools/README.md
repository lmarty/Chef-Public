Description
===========

Installs [AWS CloudWatch cli tools.](http://aws.amazon.com/developertools/2534).

Requirements
============
## Platform

Tested on Ubuntu 12.04.1 Should work on any Ubuntu/Debian platforms.

## Cookbooks

Opscode cookbooks:

* aws
* java

## Data bag

* [aws](http://community.opscode.com/cookbooks/aws)

**IMPORTANT NOTE**

### set correct `java_home` attribute
    default_attributes(
      :java => {
          :java_home => "/usr/lib/jvm/java-6-openjdk-amd64"
       }
    )

Attributes
==========

See `attributes/default.rb` for default values.

* `node["aws"]["data_bag_item"]` - Specifies aws data_bag_item containing
  aws credentials, default `main`.

Recipes
=======

default
-------

Installs AWS CloudWatch Command Line Tools

ec2-write-memory-metrics
-------

Adds Memory metrics reporting to CloudWatch:
Reports MemoryFree in MB, % MemoryUsed and SwapUsed in MB

See `templates/default/ec2-write-memory-metrics.sh` for more details.


Usage
=====

Simply include the `aws-cloud-watch-cli-tools` to install the tools.
Include `aws-cloud-watch-cli-tools::ec2-write-memory-metrics` for memory metrics.

License and Author
==================

Author:: Vitaly Gorodetsky (<technical@applicaster.com>)

Copyright:: 2013, Applicaster LTD

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
