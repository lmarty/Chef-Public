name             "notification_handler"
maintainer       "nagalakshmi_n"
maintainer_email "nagalakshmi.n@cloudenablers.com"
license          "Apache 2.0"
description      "Installs/Configures notification handler"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.0"

depends "chef_handler"

%w{ debian ubuntu redhat centos fedora scientific amazon windows oracle}.each do |os|
    supports os
end
