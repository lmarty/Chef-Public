maintainer       "Addolux LLC"
maintainer_email "john.larsen@addolux.com"
license          "Apache License, Version 2.0"
description      "Configures atg on jboss"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.1"

depends "java, jboss-atg, generic-users and sudoers"

%w{ centos redhat fedora }.each do |os|
  supports os
end