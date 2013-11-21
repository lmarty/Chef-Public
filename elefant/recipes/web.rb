include_recipe "apache2"
include_recipe "mysql::server"
include_recipe "php"
include_recipe "php::module_sqlite3"
include_recipe "php::module_mysql"
include_recipe "apache2::mod_php5"

if node.has_key?("ec2")
	server_fqdn = node['ec2']['public_hostname']
else
	server_fqdn = node['fqdn']
end

directory node['elefant']['document_root'] do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
end

apache_site "000-default" do
	enable false
end

web_app "elefant" do
	template "elefant.conf.erb"
	document_root node['elefant']['document_root']
	server_name server_fqdn
	server_aliases node['elefant']['server_aliases']
end

