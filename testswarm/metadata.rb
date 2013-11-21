maintainer       "Hadrien Dorio"
maintainer_email "hadrien.dorio@gmail.com"
license          "Apache v2.0"
description      "Installs/Configures TestSwarm"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "php"
depends "openssl"
depends "apache2"
depends "mysql"

supports "ubuntu"

attribute 'testswarm/db/name',
  :display_name => "Database",
  :description => "Name of the MySQL database",
  :type => "string",
  :default => "testswarm"
attribute 'testswarm/db/user',
  :display_name => "Username",
  :description => "username to connect to the database",
  :type => "string",
  :default => "testswarm"
attribute 'testswarm/db/password',
  :display_name => "Password",
  :description => "password to connect to the database",
  :type => "string",
  :calculated => true
attribute 'testswarm/version',
  :display_name => "Version",
  :description => "TestSwarm release version to install",
  :type => "string",
  :default => "master"
attribute 'testswarm/dir',
  :display_name => "Directory",
  :description => "installation directory",
  :type => "string",
  :default => "/var/www/testswarm"
attribute 'testswarm/url_path',
  :display_name => "URL path",
  :description => "base URL to access TestSwarm",
  :type => "string",
  :default => "/testswarm"
