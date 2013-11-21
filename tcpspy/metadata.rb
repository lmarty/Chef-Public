maintainer       "John Dewey"
maintainer_email "john@dewey.ws"
license          "Apache 2.0"
description      "Installs/Configures tcpspy"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe           "tcpspy", "Installs/Configures tcpspy"

%w{ centos debian ubuntu }.each do |os|
  supports os
end
