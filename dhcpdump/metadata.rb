name             'dhcpdump'
maintainer       'Rilindo Foster'
maintainer_email 'rilindo.foster@monzell.com'
license          'All rights reserved'
description      'Installs dhcpdump'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'
%W{ubuntu rhel centos}.each do | os |
  supports os
end