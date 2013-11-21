#
# Cookbook Name:: wikiarguments
# Recipe:: default
#
# Copyright 2013, computerlyrik
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
#

package "subversion" do
  action :install
end
subversion "/wikiarguments" do
  repository "http://wikiarguments.googlecode.com/svn/trunk/"
  action :checkout
end

### -- Install Mysql -- ##

# secure password generation
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['wikiarguments']['database']['password'] = secure_password
ruby_block "save node data" do
  block do
    node.save
  end
  not_if { Chef::Config[:solo] }
end



# Helper variables
database = node['wikiarguments']['database']['database']
database_user = node['wikiarguments']['database']['username']
database_password = node['wikiarguments']['database']['password']
database_host = node['wikiarguments']['database']['host']
database_connection = {
  :host     => database_host,
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

# Create the database
mysql_database database do
  connection      database_connection
  action          [:create,:query]
  sql_query " source /wikiarguments/sql/structur.sql;
              source /wikiarguments/sql/data.sql;"
end

# Create the database user
mysql_database_user database_user do
  connection      database_connection
  password        database_password
  database_name   database
  action          :create
end

# Grant all privileges to user on database
mysql_database_user database_user do
  connection      database_connection
  database_name   database
  action          :grant
end





template "/src/production_base/etc/config.php" do
  variables ({
    "mysql_dbname" => node['wikiarguments']['database']['database'],
    "mysql_user" => node['wikiarguments']['database']['username'],
    "mysql_password" => node['wikiarguments']['database']['password'],
    "mysql_host" => node['wikiarguments']['database']['host']
    })
end


### -- Install Webserver -- ##
# Lighttpd with mod_rewrite or Apache2 with mod_rewrite.

%w{php5 php5-memcache php5-imap memcached}.each do |pkg|
  package pkg
end

if node['wikiarguments']['webserver'] == "lighttpd"

  package "lighttpd"
  service "lighttpd"

  template "/etc/lighttpd/conf-available/70-wikiarguments.conf" do
    source "wikiarguments-lighttpd.erb"
    mode 0644
    notifies :restart, resources(:service => "lighttpd")
  end

  link "/etc/lighttpd/conf-enabled/70-wikiarguments.conf" do
    to "/etc/lighttpd/conf-available/70-wikiarguments.conf"
    notifies :restart, resources(:service => "lighttpd")
  end

end
#TODO SUPPORT APACHE2
#*** Installation details for Apache2 ***
#* The .htaccess file is currently only experimental and may require some modifications.
#* If you use apache2, use /apache2/.htaccess for mod_rewrite,
#i.e. copy it to your production_base folder.


#TODO SUPPORT SHORTENER
if node['wikiarguments']['shortener']
  codebase = "/src/shortener_base"
else
  codebase = "/src/production_base"
end











