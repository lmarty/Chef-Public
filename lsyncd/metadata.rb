maintainer        "Brian Flad"
maintainer_email  "bflad@wharton.upenn.edu"
license           "Apache 2.0"
description       "Installs/configures lsyncd."
version           "0.1.0"
recipe            "lsyncd", "Installs/configures lsyncd."
recipe            "lsyncd::source", "Installs lsyncd from source."

%w{ yum }.each do |d|
  depends d
end

%w{ amazon centos redhat scientific }.each do |os|
  supports os
end
