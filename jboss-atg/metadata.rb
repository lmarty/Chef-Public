maintainer       "John Larsen"
maintainer_email "john.larsen@addolux.com"
license          "Apache v2.0"
description      "Installs/Configures jboss"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.3"

depends "java"

recipe "jboss-atg", "installs jboss eap from file server"

%w{ centos redhat fedora }.each do |os|
  supports os
end
