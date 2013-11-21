name             "phploc"
maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures phploc"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.6"

%w{ debian ubuntu redhat centos fedora scientific amazon }.each do |os|
supports os
end

depends "php"
depends "composer"

recipe "phploc", "Installs phploc."
recipe "phploc::composer", "Installs phploc using composer."
recipe "phploc::pear", "Installs phploc using pear."
recipe "phploc::phar", "Installs phploc using phar."