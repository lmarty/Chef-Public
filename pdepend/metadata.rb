name             "pdepend"
maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures pdepend"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.4"

%w{ debian ubuntu redhat centos fedora scientific amazon }.each do |os|
supports os
end

depends "php"
depends "composer"

recipe "pdepend", "Installs pdepend."
recipe "pdepend::composer", "Installs pdepend using composer."
recipe "pdepend::pear", "Installs pdepend using pear."
recipe "pdepend::phar", "Installs pdepend using phar."