maintainer       "John Dewey"
maintainer_email "john@dewey.ws"
license          "Apache 2.0"
description      "Installs/Configures lldpd"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

recipe           "lldpd", "Installs/Configures lldpd"

%w{ debian ubuntu }.each do |os|
  supports os
end
