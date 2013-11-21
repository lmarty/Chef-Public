# Cookbook Name:: seyren
# Attribute File:: default

include_attribute "maven::default"
override['maven']['version'] = "3"

# apache_auth type = digest (if apache2 fronts tomcat);
# specify both realm and vhost_servername to create vhost
default['seyren']['apache_auth']['realm'] = nil
default['seyren']['apache_auth']['vhost_interface'] = node['ipaddress']
default['seyren']['apache_auth']['vhost_port'] = 80
default['seyren']['apache_auth']['vhost_servername'] = nil
default['seyren']['apache_auth']['vhost_server_aliases'] = nil
