name             "rackspacecloudbackup"
maintainer       "David Joos"
maintainer_email "development@davidjoos.com"
license          "MIT"
description      "Installs/Configures Rackspace Cloud Backup Agent aka RCBU Agent"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ debian ubuntu redhat centos fedora }.each do |os|
supports os
end