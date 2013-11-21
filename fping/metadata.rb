name             'fping'

maintainer       'David Radcliffe'
maintainer_email 'radcliffe.david@gmail.com'
license          'MIT'
description      'Installs fping'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'fping', 'Installs fping utility'

depends 'yum'

supports 'redhat'
supports 'centos'
