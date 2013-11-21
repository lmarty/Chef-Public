name             'thruk'
maintainer       'Tech Financials'
maintainer_email 'marthag@techfinancials.com'
license          'Apache 2.0'
description      'Installs/Configures thruk'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.1'

depends "yum"
depends "apache2"

supports "centos"
supports "debian"
