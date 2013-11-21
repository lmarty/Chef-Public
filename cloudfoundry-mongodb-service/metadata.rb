name             "cloudfoundry-mongodb-service"
maintainer       "Andrea Campi"
maintainer_email "andrea.campi@zephirworks.com"
license          "Apache 2.0"
description      "Installs/Configures cloudfoundry-mongodb-service"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.1"

%w( ubuntu ).each do |os|
  supports os
end

depends "cloudfoundry", "~> 1.3.1"
depends "cloudfoundry_service", "~> 1.2.2"
depends "mongodb"
