#
# Cookbook Name:: gallery
# Recipe:: database-mysql

include_recipe "php"
include_recipe "php::module_mysql"

if node[:gallery][:uselocalmysqld]

  # the default is usually to install a local mysql server
  include_recipe "mysql::server"
  include_recipe "mysql::ruby"

  connection_info = {:host => node[:gallery][:dbhost], :username => 'root', :password => node[:mysql][:server_root_password]}

else

  # if we don't want a local mysql server attributes can be used to specify
  # the role and hostname of the remote db server.
  # NOTE: this assumes the remote mysql server was configured with the opscode
  # mysql cookbook.
  if Chef::Config[:solo]
    Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
  else
    mysql_root_password = search(:node, "role:#{node[:gallery][:dbrole]}").first[:mysql][:server_root_password]

    connection_info = {:host => node[:gallery][:dbhost], :username => 'root', :password => mysql_root_password }
  end
end

include_recipe "database"

# create database
mysql_database node[:gallery][:dbname] do
  connection connection_info
  action :create
end

# grant all privilages on the database
mysql_database_user node[:gallery][:dbuser] do
  connection connection_info
  database_name node[:gallery][:dbname]
  password node[:gallery][:dbpass]
  action :grant
end

execute "install_gallery_dbschema" do
  command "php #{node[:gallery][:wwwdir]}/gallery-#{node[:gallery][:version]}/installer/index.php install -h #{node[:gallery][:dbhost]} -u #{node[:gallery][:dbuser]} -p #{node[:gallery][:dbpass]} -d #{node[:gallery][:dbname]}"
  not_if { ::File.exists?("#{node[:gallery][:wwwdir]}/gallery-#{node[:gallery][:version]}/gallery_dbschema.txt") }
  notifies :query, "mysql_database[adminsetpass]", :immediately
end

file "#{node[:gallery][:wwwdir]}/gallery-#{node[:gallery][:version]}/gallery_dbschema.txt" do
   content "# This file is generated by Chef\nInstallation of the Gallery database schema has been completed."
   mode "0644"
   action :create_if_missing
end

mysql_database "adminsetpass" do
  connection connection_info
  database_name node[:gallery][:dbname]
  sql "UPDATE users SET password = MD5('#{node[:gallery][:adminpass]}'), email = '#{node[:gallery][:adminemail]}' WHERE name = 'admin';"
  action :nothing
end
