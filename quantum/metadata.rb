name             "quantum"
maintainer       "Opscode, Inc."
maintainer_email "gmiranda@opscode.com"
license          "Apache 2.0"
description      "The OpenStack Networking service Quantum."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

%w{ ubuntu }.each do |os|
  supports os
end

%w{ database mysql glance osops-utils }.each do |dep|
  depends dep
end
