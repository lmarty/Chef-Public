maintainer       "Sergio Rubio"
maintainer_email "rubiojr@frameos.org"
license          "Apache 2.0"
description      "Installs/Configures nventory"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

%w{ abiquo redhat centos scientific }.each do |os|
  supports os, ">= 5.0"
end
