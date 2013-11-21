name             'clonezillalive'
maintainer       'bcs kommunikationsloesungen'
maintainer_email 'Arnold Krille <a.krille@b-c-s.de>'
license          'Apache License, Version 2.0'
description      'Installs/Configures clonezillalive'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports         'debian', '>= 7.0'

depends          'tftp'
depends          'nfs'
