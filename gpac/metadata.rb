name             "gpac"
maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures gpac"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ debian ubuntu }.each do |os|
supports os
end

depends "build-essential"
depends "subversion"

recipe "gpac", "Installs gpac."
recipe "gpac::package", "Installs gpac using packages."
recipe "gpac::source", "Installs gpac from source."