name             'sargrapho'
maintainer       'Jason Cannon'
maintainer_email 'jason@thisidig.com'
description      'Installs SarGraphO'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

%w{ amazon centos oracle scientific redhat fedora }.each do |os|
  supports os
end
