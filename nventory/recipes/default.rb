#
# Cookbook Name:: nventory
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

script "install rbel repo" do
  interpreter "bash"
  user "root"
  rbel_package = ''
  if node[:platform_version] =~ /^6/
    rbel_package = 'rbel6'
  else
    rbel_package = 'rbel5'
  end
  code <<-EOH
    rpm -Uvh http://rbel.co/#{rbel_package}
  EOH
  not_if { File.exist?("/etc/yum.repos.d/#{rbel_package}.repo") }
end

directory node[:nventory_install_dir] do
  action :create
  recursive true
end

remote_file "/tmp/nventory-#{node[:nventory_version]}.tar.gz" do
  source "http://downloads.sourceforge.net/project/nventory/nventory/#{node[:nventory_version]}/nventory-#{node[:nventory_version]}.tar.gz" 
  not_if { File.directory? "#{node[:nventory_install_dir]}/nventory" }
end

script "install nventory" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -xzf nventory-#{node[:nventory_version]}.tar.gz
    mv nventory-#{node[:nventory_version]}/server #{node[:nventory_install_dir]}/nventory
  EOH
  not_if { File.directory? "#{node[:nventory_install_dir]}/nventory" }
end

%w{ruby-devel gcc make mysql-devel libxml2-devel libxslt-devel openssl-devel gcc-c++ zlib-devel pcre-devel nginx mysql-server graphviz}.each do |pkg|
  package pkg do
    action :install
  end
end

gem_package "rails" do
  action :install
  version node[:rails_version]
  version '2.3.2'
end
gem_package "RedCloth" do
  action :install
  version '3.0.4'
end
gem_package "ruby-net-ldap" do
  action :install
  version '0.0.4'
end
gem_package "mongrel" do
  action :install
  version '1.1.5'
end
gem_package "mislav-will_paginate" do
  action :install
  version '2.3.2'
  options "--source http://gems.github.com/"
end

%w{ruport acts_as_reportable starling fast_xs fastercsv facter hpricot mongrel mysql ruby-graphviz unicorn workling ruby-debug}.each do |gem|

  gem_package gem do
    action :install
  end
end

service 'mysqld' do
  action [:enable, :start]
end

template "/tmp/create_schema.sql" do
  source "create_schema.sql.erb"
end

template "#{node[:nventory_install_dir]}/nventory/config/database.yml" do
  source "database.yml.erb"
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
end
service 'nginx' do
  action [:enable, :start]
end

script "create database" do
  interpreter "bash"
  user "root"
  code <<-EOH
    mysql -u root < /tmp/create_schema.sql
  EOH
  not_if "mysql -e 'show databases'|grep kinton"
end

script "rails migrations" do
  interpreter "bash"
  user "root"
  cwd "/opt/nventory"
  code <<-EOH
    RUBYOPT="-rthread" rake db:migrate
  EOH
end

ruby_block 'Setup Abiquo EE Yum repository' do 
  block do
    buf = File.read("#{node[:nventory_install_dir]}/nventory/app/controllers/application_controller.rb")
    buf.gsub!(/include SslRequirement/, '#include SslRequirement')
    File.open("#{node[:nventory_install_dir]}/nventory/app/controllers/application_controller.rb", 'w') { |f| f.puts buf }
    buf = File.read("#{node[:nventory_install_dir]}/nventory/app/controllers/login_controller.rb")
    buf.gsub!("ssl_required :login", "#ssl_required :login")
    File.open("#{node[:nventory_install_dir]}/nventory/app/controllers/login_controller.rb", 'w') { |f| f.puts buf }
  end
end

script "start rails" do
  interpreter "bash"
  user "root"
  cwd "/opt/nventory"
  code <<-EOH
    RUBYOPT="-rthread" ruby script/server -d -p 8080
  EOH
end
