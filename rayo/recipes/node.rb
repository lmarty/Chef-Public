#
# Cookbook Name:: rayo
# Recipe:: config
#
# Copyright 2011, Voxeo Labs
#
# All rights reserved - Do Not Redistribute
#
include_recipe "prism"


class Chef::Recipe
  include Rayo
end

o                       =  node["prism"]["user"]
g                       =  node["prism"]["group"]
file_cache_path         =  Chef::Config["file_cache_path"]
prism_path              =  node["prism"]["path"]["prism"]
node_ip                 =  node["rayo"]["bindAddress"]

##########################################

remote_file "#{file_cache_path}/rayo.war" do
  source node["rayo"]["node"]["artifact"]
  mode 0744
  notifies :run, "script[deploy rayo node war]", :immediately
  checksum Rayo.get_header(node["rayo"]["node"]["artifact"])
end

script "deploy rayo node war" do
  interpreter "bash"
  action :nothing
  user "root"
  cwd file_cache_path
  code <<-EOH
  rm -rf #{prism_path}/apps/rayo
  unzip -o #{file_cache_path}/rayo.war -d #{prism_path}/apps/rayo/
  chown -R #{o}.#{g} #{prism_path}/apps/rayo
  EOH
  not_if{ Rayo.sessions && Rayo.in_routing(node["rayo"]["bindAddress"]) }
  notifies :restart, "service[voxeo-as]"
end

template "#{prism_path}/apps/rayo/WEB-INF/xmpp.xml" do
  source "xmpp_node.xml.erb"
  owner o
  group g
  mode 0664
  notifies :restart, resources(:service => "voxeo-as")
  not_if{ Rayo.sessions > 0 && Rayo.in_routing(node_ip) }
end

template "#{prism_path}/apps/rayo/WEB-INF/classes/jolokia-access.xml" do
  source "jolokia-access.xml.erb"
  owner o
  group g
  mode 0664

  notifies :restart, resources(:service => "voxeo-as")
  not_if{ Rayo.sessions > 0 && Rayo.in_routing(node_ip) }
end

cookbook_file "#{prism_path}/apps/ROOT/index.jsp" do
  source "index.jsp"
  owner o
  group g
  mode 0660
end

template "#{prism_path}/apps/rayo/WEB-INF/classes/rayo-routing.properties" do
  source "rayo-routing.properties.erb"
  owner o
  group g
  mode 0664
  variables(
    :routes => node["rayo"]["node"]["routes"]
  )
  notifies :restart, resources(:service => "voxeo-as")
  not_if{ Rayo.sessions > 0 && Rayo.in_routing(node_ip) }
end
