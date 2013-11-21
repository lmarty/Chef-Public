name             'rdiff-backup'
maintainer       'Piratenfraktion NRW'
maintainer_email 'it+cookbooks@piratenfraktion-nrw.de'
license          'GPLv3'
description      'Installs/Configures rdiff-backup'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.1'

depends 'ssh_known_hosts'
depends 'sudo'
