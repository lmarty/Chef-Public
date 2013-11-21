name             'sensu_server'
maintainer       'Ian Chilton'
maintainer_email 'ian@ichilton.co.uk'
license          'All rights reserved'
description      'Setup a Sensu Server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'ubuntu'
supports 'debian'
supports 'centos'
supports 'redhat'
supports 'fedora'

depends 'sensu'
