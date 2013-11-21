name              "cloudfoundry-nginx"
maintainer        "Andrea Campi"
maintainer_email  "andrea.campi@zephirworks.com"
license           "Apache 2.0"
description       "Installs and configures nginx for CloudFoundry"
version           "1.0.4"

%w{ ubuntu }.each do |os|
  supports os
end

%w{ cloudfoundry nginx }.each do |cb|
  depends cb
end
