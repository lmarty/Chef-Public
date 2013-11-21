# Directory to where fanout is installed
default['fanout']['dir'] = '/opt/fanout'

# Symlink binary to
default['fanout']['bin'] = '/usr/local/bin/fanout'

# The TCP port where fanout listens
default['fanout']['port'] = '1986'

# Optionally run as a different user
default['fanout']['run-as'] = nil

# Set a limit to the number of concurrent clients
default['fanout']['client-limit'] = nil

# Logfile location
default['fanout']['logfile'] = '/var/log/fanout'

# Maximum logfile size in MB
default['fanout']['max-logfile-size'] = 10