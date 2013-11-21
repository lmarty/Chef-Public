name             'zotonic'
version          '0.2.0'

maintainer       'Arjan Scherpenisse'
maintainer_email 'arjan@miraclethings.nl'
license          'MIT'
description      'Installs/Configures Zotonic'
long_description "" #IO.read(File.join(File.dirname(__FILE__), 'README.md'))

depends "erlang", ">= 1.2.0"
depends "apt", ">= 1.7.0"

recipe "zotonic", "Installs Zotonic via PPA or source"
recipe "zotonic::ppa", "Installs Zotonic via PPA"

supports "ubuntu", ">= 12.04"
supports "debian"

