name             "reportchef"
maintainer       "Alan Harper"
maintainer_email "alan@appfisison.com"
license          "Apache 2.0"
description      "Installs/Configures handler"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.3"

depends "chef_handler"

%w{ debian ubuntu redhat centos fedora scientific amazon oracle}.each do |os|
    supports os
end
