name		 "percona-toolkit"
maintainer       "Derek Schultz"
maintainer_email "dschultz@brinkster.com"
license          "Apache 2.0"
description      "Installs Percona apt/yum repository and percona-toolkit package."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ centos debian redhat ubuntu }.each do |os|
	supports os
end

depends "apt"
depends "yum"

recipe "percona-toolkit",	"Installs the Percona Toolkit software."
recipe "percona-toolkit::package_repo",	"Sets up the package yum/apt repository."
