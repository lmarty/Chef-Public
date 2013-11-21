#
# Cookbook Name:: rayo_gateway
# Recipe:: default
#
# Copyright 2011, Voxeo Labs
#
# All rights reserved - Do Not Redistribute
#
include_recipe "prism"
include_recipe "cassandra"

class Chef::Recipe
  include Rayo
end

node["rayo"]["cluster"]  =  true

o                      =  node["prism"]["user"]
g                      =  node["prism"]["group"]
file_cache_path        =  Chef::Config["file_cache_path"]
prism_path             =  node["prism"]["path"]["prism"]
gateway_checksum       =  node["rayo"]["gateway"]["checksum"]
node_ip                =  node["rayo"]["bindAddress"]

##########################################

remote_file "#{file_cache_path}/rayo_gateway.war" do
  source node["rayo"]["gateway"]["artifact"]
  mode 0744
  notifies :run, "script[deploy rayo gateway war]", :immediately
  checksum Rayo.get_header(node["rayo"]["gateway"]["artifact"])
end

script "deploy rayo gateway war" do
  interpreter "bash"
  user "root"
  action :nothing
  cwd file_cache_path
  code <<-EOH
  rm -rf #{prism_path}/apps/rayo_gateway
  unzip -o #{file_cache_path}/rayo_gateway.war -d #{prism_path}/apps/rayo_gateway/
  chown -R #{o}.#{g} #{prism_path}/apps/rayo_gateway
  EOH
  not_if{ Rayo.sessions(:gateway=>true) && Rayo.in_routing(node["rayo"]["bindAddress"]) }
  notifies :restart, "service[voxeo-as]"
end

template "#{prism_path}/apps/rayo_gateway/WEB-INF/xmpp.xml" do
  source "xmpp_gateway.xml.erb"
  owner o
  group g
  mode 0664
  variables({
    :serve_domains=> node["rayo"]["gateway"]["external"] | node["rayo"]["gateway"]["internal"] | node["rayo"]["gateway"]["domains"] | ( node["rayo"]["gateway"]["serve_domains"] || [] )
  })

  notifies :restart, resources(:service => "voxeo-as")
  not_if{ Rayo.sessions(:gateway=>true) > 0 && Rayo.in_routing(node_ip) }

end

template "#{prism_path}/apps/rayo_gateway/WEB-INF/external-domains.properties" do
  source "external-domains.properties.erb"
  owner o
  group g
  mode 0664
  variables(
    :external_domains  => node["rayo"]["gateway"]["external"]
  )
  notifies :restart, resources(:service => "voxeo-as")
  not_if{ Rayo.sessions(:gateway=>true) > 0 && Rayo.in_routing(node_ip) }

end

template "#{prism_path}/apps/rayo_gateway/WEB-INF/classes/jolokia-access.xml" do
  source "jolokia-access.xml.erb"
  owner o
  group g
  mode 0664
  notifies :restart, resources(:service => "voxeo-as")
  not_if{ Rayo.sessions(:gateway=>true) > 0 && Rayo.in_routing(node_ip) }
end

template "#{prism_path}/apps/rayo_gateway/WEB-INF/cassandra.properties" do
  source "cassandra.properties.erb"
  owner o
  group g
  mode 0774
  variables(
    :test_data  => node["rayo"]["cassandra"]["test_data"]
  )
  notifies :restart, resources(:service => "voxeo-as")
  not_if{ Rayo.sessions(:gateway=>true) > 0 && Rayo.in_routing(node_ip) }
end

template "#{prism_path}/apps/rayo_gateway/WEB-INF/internal-domains.properties" do
  source "internal-domains.properties.erb"
  owner o
  group g
  mode 0664
  variables(
    :internal_domains  => node["rayo"]["gateway"]["internal"]
  )

  notifies :restart, resources(:service => "voxeo-as")
  not_if{ Rayo.sessions(:gateway=>true) > 0 && Rayo.in_routing(node_ip) }

end

template "#{prism_path}/apps/rayo_gateway/WEB-INF/classes/rayo-routing.properties" do
  source "rayo-routing.properties.erb"
  owner o
  group g
  mode 0664
  variables(
    :routes => node["rayo"]["gateway"]["routes"],
    :test_users => node["prism"]["sipmethod_users"]["number_of_test_users"]
  )

  notifies :restart, resources(:service => "voxeo-as")
  not_if{ Rayo.sessions(:gateway=>true) > 0 && Rayo.in_routing(node_ip) }

end
