name             'oclint'
maintainer       'Chris Streeter'
maintainer_email 'chris@chrisstreeter.com'
license          'MIT'
description      'Installs/Configures oclint'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

recipe 'default', 'Installs OCLint using the node install method'
recipe 'package', 'Installs a pre-built OCLint using the node install method'
recipe 'source',  'Installs OCLint from source'

depends 'build-essential'
depends 'git'
depends 'python'
