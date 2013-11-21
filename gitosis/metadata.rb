maintainer       "Maciej Pasternacki"
maintainer_email "maciej@pasternacki.net"
license          "MIT"
description      "Installs/Configures gitosis"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1.0"

supports "debian"

depends "git"
depends "ssh_known_hosts"
