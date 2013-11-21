maintainer       "John Dewey"
maintainer_email "john@dewey.ws"
license          "Apache 2.0"
description      "Installs/Configures smem"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

recipe           "smem", "Installs/Configures smem"

%w{ debian ubuntu }.each do |os|
  supports os
end
