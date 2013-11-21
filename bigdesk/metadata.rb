maintainer       "SourceIndex IT-Service"
maintainer_email "packages@sourceindex.de"
license          "Apache 2.0"
description      "Installs/Configures bigdesk"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "apache2"
depends "elasticsearch"
supports "debian"
supports "ubuntu"

