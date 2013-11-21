maintainer       "John Dewey"
maintainer_email "john@dewey.ws"
license          "Apache 2.0"
description      "Installs/Configures iperf"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.0"

recipe           "iperf", "Installs/Configures iperf"

%w{ centos debian ubuntu }.each do |os|
  supports os
end
