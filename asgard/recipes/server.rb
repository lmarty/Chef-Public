#
# Cookbook Name:: asgard
# Recipe:: server
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


# == JAVA SETUP
#
# Netflix recommends Java 6 for Asgard.
#
include_recipe "java"

# == TOMCAT SETUP
#
include_recipe "tomcat::base"

tomcat "asgard" do
  action              :install

  user                "tomcat"
  auto_deploy         false
  manage_config_file  true
  shutdown_wait       node["tomcat"]["shutdown_wait"]
  jvm_opts            node["tomcat"]["jvm_opts"]
  jmx_opts            node["tomcat"]["jmx_opts"]
  webapp_opts         ["-DASGARD_HOME=#{node['asgard']['home']}/.asgard"]
  more_opts           node["tomcat"]["more_opts"]
end

# == ASGARD SETUP
#
if node["asgard"]["war"]["url"] =~ /example.com/
  Chef::Application.fatal!("You must change the Asgard download link to your private repository. You can not download Asgard directly without a web broswer.")
end

if node["asgard"]["war"]["checksum"] == "1234567890"
  Chef::Application.fatal!("You must change the Asgard checksum to match the Asgard war file in your private repository.")
end

directory "#{node['asgard']['home']}/.asgard" do
  mode "0770"
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
end

remote_file "#{node['asgard']['home']}/webapps/ROOT.war" do
  source node["asgard"]["war"]["url"]
  checksum node["asgard"]["war"]["checksum"]
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
  # notifies :restart, resources(:service => "asgard")
end

# template "/opt/tomcat/asgard/.asgard/Config.groovy" do
#   cookbook node["asgard"]["_config"]["cookbook"]
#   source node["asgard"]["_config"]["source"]
#   owner node["tomcat"]["user"]
#   group node["tomcat"]["group"]
#   mode "660"
# end