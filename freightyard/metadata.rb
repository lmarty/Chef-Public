maintainer       "Maciej Pasternacki"
maintainer_email "maciej@pasternacki.net"
license          "MIT"
description      "Configures freightyard deb package build system"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

supports "ubuntu"
supports "debian"

depends "freight"
depends "perl"
