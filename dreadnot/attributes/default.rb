# encoding: utf-8

default['dreadnot']['install_nodejs'] = true

default['nodejs']['version'] = '0.6.21'
default['nodejs']['install_method'] = 'source'

case node['platform_family']
when 'smartos'
  default['nodejs']['install_nodejs'] = false
end

default['dreadnot']['user'] = 'dreadnot'
default['dreadnot']['group'] = 'dreadnot'
default['dreadnot']['gid'] = 849
default['dreadnot']['home'] = '/opt/dreadnot'
default['dreadnot']['embedded_stacks'] = false
default['dreadnot']['shell'] = '/bin/bash'
default['dreadnot']['instance_prefix'] = '/opt/dreadnot/instances'
default['dreadnot']['instance_template_file'] = 'local_settings.js.erb'
default['dreadnot']['instance_template_cookbook'] = 'dreadnot'
default['dreadnot']['instances'] = {}
default['dreadnot']['upstart_template_file'] = 'dreadnot.conf.erb'
default['dreadnot']['upstart_template_cookbook'] = 'dreadnot'
