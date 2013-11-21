#
# Cookbook Name:: enstratius_agent_proxy
# Recipe:: default
#
# Copyright 2013, Enstratius
#
# All rights reserved - Do Not Redistribute
#
include_recipe "runit"
include_recipe "java"

user node['enstratius_agent_proxy']['user'] do
  supports :manage_home=>true
  system true
  shell "/bin/false"
  comment "ES Agent Proxy"
  home node['enstratius_agent_proxy']['home_dir']
end

group node['enstratius_agent_proxy']['group'] do
  action :create
  members node['enstratius_agent_proxy']['user']
  append true
  system true
end


directory node['enstratius_agent_proxy']['installdir'] do
  mode "0750"
  owner node['enstratius_agent_proxy']['user']
  group node['enstratius_agent_proxy']['group']
  action :create
end 

remote_file "#{Chef::Config[:file_cache_path]}/#{node['enstratius_agent_proxy']['filename']}" do
  source "#{node['enstratius_agent_proxy']['url']}/#{node['enstratius_agent_proxy']['filename']}"
  checksum "#{node['enstratius_agent_proxy']['checksum']}"
  mode "0644"
  owner "root"
  group "root"
  backup false
end

bash "extract-agentproxy" do
  user node['enstratius_agent_proxy']['user']
  group node['enstratius_agent_proxy']['group']
  cwd node['enstratius_agent_proxy']['installdir']
  code <<-EOH
	tar -zxvf #{Chef::Config[:file_cache_path]}/#{node['enstratius_agent_proxy']['filename']} \
  --strip-components=1 \
  -C "#{node['enstratius_agent_proxy']['installdir']}/"
  rc=$?
  if [[ $rc -ne 0 ]]; then
    exit 1
  else
    touch #{node['enstratius_agent_proxy']['installdir']}/.extracted
  fi
  EOH
  not_if "test -f #{node['enstratius_agent_proxy']['installdir']}/.extracted"
end

cookbook_file "#{node['enstratius_agent_proxy']['installdir']}/#{node['enstratius_agent_proxy']['ssl_cert']}" do
  owner node['enstratius_agent_proxy']['user']
  group node['enstratius_agent_proxy']['group']
  mode '0640'
  cookbook node['enstratius_agent_proxy']['ssl_cookbook']
end

cookbook_file "#{node['enstratius_agent_proxy']['installdir']}/#{node['enstratius_agent_proxy']['ssl_key']}" do
  owner node['enstratius_agent_proxy']['user']
  group node['enstratius_agent_proxy']['group']
  mode '0640'
  cookbook node['enstratius_agent_proxy']['ssl_cookbook']
end

bash "install-ssl-cert" do
  user node['enstratius_agent_proxy']['user']
  group node['enstratius_agent_proxy']['group']
  cwd node['enstratius_agent_proxy']['installdir']
  code <<-EOH
  ./pem-to-jks.sh proxy.pem proxy.key
  cp keystore.jks truststore.jks
  EOH
  not_if "test -f #{node['enstratius_agent_proxy']['installdir']}/keystore.jks"
  not_if "test -f #{node['enstratius_agent_proxy']['installdir']}/truststore.jks"
end

template "#{node['enstratius_agent_proxy']['installdir']}/agentproxy.properties" do
  source "agent.properties.erb"
  user node['enstratius_agent_proxy']['user']
  group node['enstratius_agent_proxy']['group']
  mode "0640"
  cookbook node['enstratius_agent_proxy']['config_cookbook']
end

include_recipe "#{node['enstratius_agent_proxy']['service_cookbook']}::#{node['enstratius_agent_proxy']['service_type']}"
