#
# Cookbook Name:: mysql_charset
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "#{node[:mysql][:confd_dir]}/charset.cnf" do
  source "charset.cnf.erb"

  variables(
    :encoding  => node[:mysql_charset][:encoding],
    :collation => node[:mysql_charset][:collation]
  )
end