#
# Cookbook Name:: powerdns
# Recipe:: server
#
# Copyright 2009, Adapp, Inc.
#

# Manual steps, run /etc/powerdns/first-run manually,
# e.g. mysql -p -f < /etc/powerdns/first-run

service "pdns" do
    supports :restart => true, :status => true, :reload => true
      action :nothing
end

execute "install_powerdns_from_rpm" do
  command "cd /tmp;rpm -Uvh http://downloads.powerdns.com/releases/rpm/pdns-static-2.9.22-1.i386.rpm"
  not_if { FileTest.exists?("/usr/sbin/pdns_server") }
  only_if do platform?("centos","redhat") end
end

if platform?("ubuntu","debian") do
  %w(pdns-server pdns-recursor pdns-backend-mysql pdns-backend-pipe pdns-backend-sqlite3 pdns-backend-sqlite).each do |p|
    package(p)
  end
end
end

directory "/etc/powerdns" do
  mode 0750
  owner "pdns"
  group "pdns"
end

template "/etc/powerdns/pdns.conf" do
  source "pdns.conf.erb"
  mode 0440
  owner "pdns"
  group "pdns"
  backup false
  variables(
    :allow_axfr_ips => node[:powerdns][:server][:allow_axfr_ips],
    :allow_recursion => node[:powerdns][:server][:allow_recursion],
    :default_soa_name => node[:powerdns][:server][:default_soa_name],
    :default_ttl => node[:powerdns][:server][:default_ttl],
    :distributor_threads => node[:powerdns][:server][:distributor_threads],
    :powerdns_address => node[:powerdns][:server][:address],
    :powerdns_username => node[:powerdns][:server][:username],
    :powerdns_password => node[:powerdns][:server][:password],
    :powerdns_database => node[:powerdns][:server][:database]
  )
  notifies :reload, resources(:service => "pdns")
end

template "/etc/powerdns/first-run" do
  source "first-run.erb"
  mode 0400
  owner "root"
  group "root"
  backup false
  variables(
    :powerdns_username => node[:powerdns][:server][:username],
    :powerdns_password => node[:powerdns][:server][:password],
    :powerdns_database => node[:powerdns][:server][:database]
  )
end
