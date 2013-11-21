default['asterisk']['source']['packages'] = %w{build-essential libssl-dev libcurl4-openssl-dev libncurses5-dev libnewt-dev libxml2-dev libsqlite3-dev uuid-dev}
default['asterisk']['source']['version']  = '11.5.1'
default['asterisk']['source']['checksum'] = 'fefa9def9c8f97c89931f12b29b3ac616ae1a8454c01c524678163061dcb42b2'

# An full download url can be supplied to specify an alternative source tarball location
default['asterisk']['source']['url'] = nil

# Should the sample config files be installed?
default['asterisk']['source']['install_samples'] = true
