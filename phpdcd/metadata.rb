name             "phpdcd"
maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures phpdcd"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.5"

%w{ debian ubuntu redhat centos fedora scientific amazon }.each do |os|
supports os
end

depends "php"

recipe "phpdcd", "Installs phpdcd using PEAR."