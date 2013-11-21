name             'berkshelf'
maintainer       'Jamie Winsor'
maintainer_email 'jamie@vialstudios.com'
license          'Apache 2.0'
description      'Installs/Configures berkshelf'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.2'

supports 'ubuntu'

depends 'runit'
depends 'rbenv', '>= 1.5.0'
depends 'nginx', '>= 1.7.0'
