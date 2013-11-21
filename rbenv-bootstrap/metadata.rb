name             'rbenv-bootstrap'
maintainer       'José P. Airosa'
maintainer_email 'me@joseairosa.com'
license          'Apache 2.0'
description      'Installs/Configures rbenv-bootstrap which will install ruby shims during chef provision'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'rbenv-bootstrap', 'Installs/Configures rbenv-bootstrap which will install ruby shims during chef provision'

%w{ centos redhat fedora ubuntu debian amazon oracle}.each { |os| supports os }

%w(rbenv).each { |d| depends d }