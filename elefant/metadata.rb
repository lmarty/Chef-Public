name             "elefant"
maintainer       "Johnny Broadway"
maintainer_email "johnny@johnnybroadway.com"
license          "MIT"
description      "Installs/configures the Elefant CMS"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.8.1"

recipe "Elefant", "Installs and configures Elefant CMS and associated LAMP stack on a single system"

%w{ php openssl }.each do |cb|
	depends cb
end

depends "apache2", ">= 0.99.4"
depends "mysql", ">= 1.0.5"
depends "build-essential"

%w{ debian ubuntu }.each do |os|
	supports os
end

attribute "Elefant/version",
	:display_name => "Elefant download version",
	:description => "Version of Elefant to download (format is '1_3_6_beta') or 'latest' for current master.",
	:default => "latest"

attribute "Elefant/document_root",
	:display_name => "Elefant installation directory",
	:description => "Location of the Elefant CMS files.",
	:default => "/var/www/elefant"

attribute "Elefant/server_aliases",
	:display_name => "Elefant server aliases",
	:description => "Elefant server aliases",
	:default => ["*"]
