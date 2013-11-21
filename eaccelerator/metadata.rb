maintainer       "Yevgeniy Viktorov"
maintainer_email "wik@rentasite.com.ua"
license          "Apache 2.0"
description      "build eAccelerator from sources"
version          "0.1.1"
recipe           "eaccelerator", "build eAccelerator from sources"

%w{ debian ubuntu redhat centos fedora suse }.each do |os|
  supports os
end
