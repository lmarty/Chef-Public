maintainer       "Spidertracks"
maintainer_email "todd@spidertracks.com"
license          "Apache 2.0"
description      "Installs/Configures client to download files from aws"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

recipe "awsclient::default", "Installs all the dependencies to use the awsclient"


depends "aws"
depends "apt"
