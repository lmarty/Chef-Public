maintainer       "FindsYou Limited"
maintainer_email "developers@findsyou.com"
license          "Apache 2.0"
description      "Installs libxslt with development packages"
version          "0.0.1"

recipe "xslt", "Installs libxslt with development packages"

%w{ centos redhat suse fedora ubuntu debian gentoo }.each do |os|
  supports os
end
