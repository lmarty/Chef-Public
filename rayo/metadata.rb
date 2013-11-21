maintainer       "Voxeo Labs"
maintainer_email "jdyer@voxeo.com"
license          "All rights reserved"
description      "Installs/Configures rayo"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.12"

%w(prism cassandra).each{|lib| depends lib}
