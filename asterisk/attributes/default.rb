default['asterisk']['install_method'] = 'source'

# Ownership / run-as user
default['asterisk']['user']   = 'asterisk'
default['asterisk']['group']  = 'asterisk'

# Path config.  The default bin path is set according to the install method (source vs package)
default['asterisk']['prefix']['bin']    = nil
default['asterisk']['prefix']['conf']   = '/etc'
default['asterisk']['prefix']['state']  = '/var'
