default[:hosts_file][:path] = '/etc/hosts'
default[:hosts_file][:custom_entries] = {}

default[:hosts_file][:fqdn] = node[:fqdn]
default[:hosts_file][:hostname] = node[:hostname]
