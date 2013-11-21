#
# Cookbook Name:: graphite
# Recipe:: default
#
# Copyright 2012, Scott M. Likens
#
#


graphite_web "graphite" do
  action [:git,:create]
end
cookbook_file "/opt/graphite/conf/graphTemplates.conf" do
  source "graphTemplates.conf"
  owner "graphite"
  group "graphite"
end
graphite_web "graphite-web" do
  action :start
  init_style "runit"
  backlog 65535
  listen_port 8080
  listen_address "0.0.0.0"
  cpu_affinity 0
  user "graphite"
  group "graphite"
  graphite_home "/opt/graphite"
end
