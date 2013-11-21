name             "fqdn"
maintainer       "Sean OMeara"
maintainer_email "someara@opscode.com"
license          "Apache2"
description      "Installs/Configures fqdn"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

depends "line"
depends "hostsfile"
