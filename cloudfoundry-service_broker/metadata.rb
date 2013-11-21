name             "cloudfoundry-service_broker"
maintainer       "Andrea Campi"
maintainer_email "andrea.campi@zephirworks.com"
license          "Apache 2.0"
description      "Installs/Configures cloudfoundry_service_broker"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.2"

%w( ubuntu ).each do |os|
  supports os
end

depends "cloudfoundry_service", "~> 1.2.2"
