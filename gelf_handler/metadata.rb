name             'gelf_handler'
maintainer       'Peter Donald'
maintainer_email 'peter@realityforge.org'
license          'Apache 2.0'
description      'Installs/Configures a Chef handler which reports run failures and to a GELF server. Derived from Jon Wood''s gem.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.6'

depends 'chef_handler'
suggests 'ohai-system_packages'
