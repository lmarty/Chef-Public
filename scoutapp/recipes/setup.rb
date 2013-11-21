#
# Cookbook Name:: scoutapp
# Recipe:: setup
#
# Copyright 2011, Efactures
#
# Apache 2.0 Licence
#



# test if server has a key and register it if account email password exist
if node[:scoutapp][:key].nil? && !node[:scoutapp][:account].nil? && !node[:scoutapp][:email].nil? && !node[:scoutapp][:password].nil?
# Here auto registration
  require 'rubygems'
  require 'scout_scout'
  ScoutScout.new("#{node[:scoutapp][:account]}", "#{node[:scoutapp][:email]}", "#{node[:scoutapp][:password]}")
  Chef::Log.info("Attempt to register #{node[:fqdn]}")
  server = ScoutScout::Server.create("#{node[:scoutapp][:name] || node[:fqdn]}")
  node.set[:scoutapp][:key] = server.key.to_s
  Chef::Log.info("Node #{node[:fqdn]} is register with key : #{node[:scoutapp][:key]}")
end

# test if server has a key and install cron
if !node[:scoutapp][:key].nil? then
#if  node.scoutapp.attribute?("key")  then
    cron "scout_cron" do
        user "root"
        path "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11R6/bin"
        command "scout --name=#{node[:scoutapp][:name] || node[:fqdn]} #{node[:scoutapp][:key]} >> /dev/null 2>&1" 
    end
end