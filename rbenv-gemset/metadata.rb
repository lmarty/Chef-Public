#encoding:utf-8
name             'rbenv-gemset'
maintainer       'José P. Airosa'
maintainer_email 'me@joseairosa.com'
license          'Apache 2.0'
description      'Installs and Configures rbenv-gemset'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

recipe 'rbenv-gemset', 'Installs and Configures rbenv-gemset'

%w{ centos redhat fedora ubuntu debian amazon oracle}.each { |os| supports os }

%w{ rbenv git }.each { |d| depends d}
