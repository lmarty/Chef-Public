name             'ovirt'
maintainer       'Jason Cannon'
maintainer_email 'jason@thisidig.com'
description      'Installs/Configures ovirt'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

%w{ centos fedora redhat }.each do |os|
  supports os
end
