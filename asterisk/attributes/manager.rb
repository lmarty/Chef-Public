# [general]
default['asterisk']['manager_enabled']         = 'yes'
default['asterisk']['manager_port']            = 5038
default['asterisk']['manager_ip_address']      = '127.0.0.1'
default['asterisk']['manager_webenabled']      = 'yes'
default['asterisk']['manager_timestampevents'] = 'yes'

# [user] section
default['asterisk']['manager_username']    = 'manager'
default['asterisk']['manager_password']    = 'password'
default['asterisk']['manager_deny']        = '0.0.0.0/0.0.0.0'
default['asterisk']['manager_permit']      = '127.0.0.1/255.255.255.0'
default['asterisk']['manager_read_perms']  = %w(system call log verbose command agent user config)
default['asterisk']['manager_write_perms'] = %w(system call log verbose command agent user config)
