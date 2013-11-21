maintainer       "John Dewey"
maintainer_email "john@dewey.ws"
license          "Apache 2.0"
description      "Installs/Configures ltrace"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.0"

recipe           "ltrace", "Installs/Configures ltrace"

%w{ centos debian ubuntu }.each do |os|
  supports os
end
