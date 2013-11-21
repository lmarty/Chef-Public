maintainer       "Sean Escriva"
maintainer_email "sean.escriva@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures mg - tiny emacs clone"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

%w{ debian ubuntu centos redhat fedora freebsd }.each do |os|
  supports os
end
