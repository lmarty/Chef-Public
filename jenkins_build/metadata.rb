name             'jenkins_build'
maintainer       'John T Skarbek'
maintainer_email 'jtslear@gmail.com'
license          'All rights reserved'
description      'Installs/Configures jenkins_build'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.0'

depends "apt"
depends "postgresql", "> 2.4.1"
depends "jenkins", "> 0.8.0"
depends "nodejs"
depends "phantomjs"
depends "git"
depends "database"
