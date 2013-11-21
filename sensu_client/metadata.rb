name             'sensu_client'
maintainer       'Ian Chilton'
maintainer_email 'ian@ichilton.co.uk'
license          'All rights reserved'
description      'Install/Setup sensu-client on a node'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'ubuntu'
supports 'debian'
supports 'centos'
supports 'redhat'
supports 'fedora'

depends 'sensu'
