name              "irssi"
maintainer        "Jared R Baldridge"
maintainer_email  "jrb@expunge.us"
license           "Apache 2.0"
description       "Installs irssi"
version           "0.2.0"

recipe "irssi",         "Installs irssi"

depends "yum"

%w{ debian ubuntu redhat centos fedora scientific amazon oracle }.each do |os|
  supports os
end
