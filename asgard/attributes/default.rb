#
# Cookbook Name:: asgard
# Attributes:: defaultß
#
# Copyright 2013, StudyBlue, Inc.
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


# == ASGARD SETTINGS
#
# TODO: MUST OVERRIDE VALUES
default["asgard"]["war"]["url"] = "http://example.com/asgard.war"
default["asgard"]["war"]["checksum"] = "1234567890"

default["asgard"]["aws"]["accounts"] = []
default["asgard"]["aws"]["accountNames"] = {  }
default["asgard"]["aws"]["accessId"] = "AWS_ACCESS_KEY"
default["asgard"]["aws"]["secretKey"] = "AWS_SECRET_KEY"
default["asgard"]["cloud"]["accountName"] = "ACCOUNT_NAME"

default["asgard"]["apache"]["server"]["admin"] = "admin@example.com"
default["asgard"]["apache"]["server"]["name"] = "asgard.example.com"
default["asgard"]["apache"]["server"]["aliases"] = []

default["asgard"]["home"] = "/opt/tomcat/asgard"
default["asgard"]["_config"]["cookbook"] = "asgard"
default["asgard"]["_config"]["source"] = "config.groovy.erb"

# == JAVA SETTINGS
#
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '6'

# == TOMCAT SETTINGS
#
default["tomcat"]["version"] = "7"
default["tomcat"]["prefix_dir"] = "/opt"
default["tomcat"]["home"] = "/opt/tomcat/default"
default["tomcat"]["jvm_opts"] = [ "-Xms512m", "-Xmx1024m", "-XX:MaxPermSize=128m", "-XX:PermSize=128m" ]
default["tomcat"]["jmx_opts"] = []
default["tomcat"]["more_opts"] = []
default["tomcat"]["shutdown_wait"] = "5"
default["tomcat"]["user"] = "tomcat"
default["tomcat"]["group"] = "tomcat"
