name              'azure'
maintainer        'Panagiotis Papadomitsos'
maintainer_email  'pj@ezgr.net'
license           'Apache 2.0'
description       'Installs and configures Windows Azure support for Linux VMs'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           IO.read(File.join(File.dirname(__FILE__), 'VERSION')).chomp rescue '0.1.0'

recipe            'azure',       'Installs and configures Windows Azure support for Linux VMs and provides an OHAI plugin'

supports          'ubuntu',      '>= 12.04'
supports          'debian',      '>= 6.0'
supports          'redhat',      '>= 6.0'
supports          'scientific',  '>= 6.0'
supports          'oracle',      '>= 6.0'

depends           'ohai',        '>= 1.1.4'
