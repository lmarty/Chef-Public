# Description

Installs and configures Netflix Asgard under Tomcat.

Can also proxy via Apache.

# Requirements

* Chef 0.9.x+

# Platforms

Supported on:

* CentOS, Red Hat, Fedora

Tested on:

* CentOS 6.3-6.4
* Chef 0.9.14, 10.14.2

# Dependencies

The following cookbooks are dependencies:

* apache
  * Only used by the `asgard::apache` recipe
* java
  * Netflix _strongly_ recommends Oracle JDK 6
* tomcat
  * Requires Tomcat 7 from:
    * [https://github.com/organicveggie/chef-tomcat](https://github.com/organicveggie/chef-tomcat)
    * [https://github.com/phillip/tomcat](https://github.com/phillip/tomcat) 
    
You must host your own copies of:

* Asgard war
* JDK

# Recipes

* `asgard::server`
  * Installs Asgard with Tomcat 7
* `asgard::apache`
  * Install Asgard with Tomcat 7 and Apache as a proxy


# Attributes

## Required Attributes

* `default["asgard"]["war"]["url"]`
  * URL for downloading Asgard war file. Must be hosted privately because Netflix uses Box to host the binaries.
* `default["asgard"]["war"]["checksum"]`
  * SHA-256 checksum of the Asgard war file.
* `default["asgard"]["aws"]["accounts"]`
  *  Array of AWS account numbers for Asgard to use.
* `default["asgard"]["aws"]["accountNames"]`
  * Hash that maps AWS account numbers to human readable names for display within Asgard.
* `default["asgard"]["aws"]["accessId"]`
  * AWS account id that Asgard should use for AWS operations.
* `default["asgard"]["aws"]["secretKey"]`
  * AWS secret key 
* `default["asgard"]["cloud"]["accountName"]`
  * Name of the primary AWS account. Should match entry in `asgard.aws.accountNames`.
* `default["java"]["jdk"]["6"]["x86_64"]["url"]`
  * URL for downloading JDK 6 tar gzip file. Must be hosted privately. Cannot download from Oracle without a browser.
* `default["java"]["jdk"]["6"]["x86_64"]["checksum"]`
  * SHA-256 checksum for the JDK


## Apache Attributes

You only need this if you include the `asgard::apache` recipe.

* `default["asgard"]["apache"]["server"]["admin"]`
  * Email address for the Apache administrator
* `default["asgard"]["apache"]["server"]["name"]`
  * Name of the Asgard server
* `default["asgard"]["apache"]["server"]["aliases"]`
  * Array of aliases for the Asgard server

# Usage

Add something like the following to your recipe or role:

```ruby
node['java']['jdk']['6']['x86_64']['url'] = 'http://example.com/jdk-6u41-linux-x64.tar.gz'
node['java']['jdk']['6']['x86_64']['checksum'] = 'd54749ac1ae3dad19643aa38d54aec1b4d8f6268e06edb744d6864d9eb8a8f31'
node["asgard"]["war"]["url"] = "http://example.com/asgard-1.1.war"
node["asgard"]["war"]["checksum"] = "207124a5127c7b9a4a7f522298935d5e595b558bbdcfba1a9c3c74c22032ac51"

node["asgard"]["aws"]["accounts"] = %w{1234567890}
node["asgard"]["aws"]["accountNames"] = { '1234567890' => "development" }
node["asgard"]["aws"]["accessId"] = "ACCESS_ID"
node["asgard"]["aws"]["secretKey"] = "SECRET_KEY"
node["asgard"]["cloud"]["accountName"] = "development"

node["asgard"]["apache"]["server"]["admin"] = "asgard@example.com"
node["asgard"]["apache"]["server"]["name"] = "asgard.example.com"
node["asgard"]["apache"]["server"]["aliases"] = [ node.name ]

include_recipe "asgard::apache"
```

The process will install Tomcat 7:

* `/opt/tomcat/`
* `/opt/tomcat/tomcat-7/`
* `/opt/tomcat/default/`

And it will install Asgard as a separate Tomcat instance with an init script:

* `/opt/tomcat/asgard/`
* `/opt/tomcat/asgard/.asgard/`
* `/opt/tomcat/asgard/.asgard/Config.groovy/`
* `/etc/default/asgard`
* `/etc/init.d/asgard`

If you use the optional `asgard::apache` recipe, it will also install Apache and setup a Virtual Host definition to proxy requests from port 80 to Tomcat Asgard on port 8080:

* `/etc/httpd/sites-enabled/asgard.conf`

# License

* Author: Sean Laurent
* Copyright: 2013 StudyBlue, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.