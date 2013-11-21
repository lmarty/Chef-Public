maintainer       "Eric G. Wolfe"
maintainer_email "wolfe21@marshall.edu"
license          "Apache 2.0"
description      "Installs/Configures vnc"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
depends          "x-windows"
depends          "gnome"

%w{ ubuntu debian redhat centos fedora }.each do |os|
  supports os
end
