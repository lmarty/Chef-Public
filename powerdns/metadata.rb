maintainer        "Scott M. Likens"
maintainer_email  "scott@likens.us"
license           'Apache 2.0'
description       "Installs powerdns, poweradmin, configures them appropriately"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version           "0.1"
recipe            "powerdns::server", "Install PowerDNS Server"
recipe            "powerdns::default", "user stuff"
recipe            "powerdns::recursor", "Install PowerDNS Recursor"
