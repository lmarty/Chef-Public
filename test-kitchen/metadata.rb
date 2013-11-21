name              "test-kitchen"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Configures Test-Kitchen"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.0"

%w{ ubuntu debian }.each do |os|
  supports os
end

depends "build-essential"
depends "vagrant"
depends "virtualbox"
