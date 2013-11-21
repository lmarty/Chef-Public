default['vifm']['install_method'] = if(node['platform_family'] == 'rhel')
  'source'
else
  'package'
end
default['vifm']['version'] = '0.7.4a'
default['vifm']['checksum'] = 'eebd67ed31ab9309fbfc06c5510cc10d'
