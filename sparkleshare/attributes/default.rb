default['sparkleshare']['user'] = "storage"
default['sparkleshare']['home'] = "/home/#{node['sparkleshare']['user']}"

default['sparkleshare']['repository'] = "#{node['sparkleshare']['home']}/default"

default['sparkleshare']['dashboard']['dir'] = "#{node['sparkleshare']['home']}/dashboard"
default['sparkleshare']['dashboard']['session_secret'] = nil

default['sparkleshare']['dashboard']['repo'] = "https://github.com/computerlyrik/sparkleshare-dashboard.git" #"https://github.com/tommyd3mdi/sparkleshare-dashboard.git"
