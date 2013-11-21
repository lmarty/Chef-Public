maintainer       "CyByL Technologies, Inc."
maintainer_email "opie@cybyl.com"
license          "Apache 2.0"
description      "Installs joe and optional extra packages."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

%w{debian ubuntu arch redhat centos fedora scientific}.each do |os|
  supports os
end

