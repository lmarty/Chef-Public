name             'siege'
maintainer       'Vasily Mikhaylichenko'
maintainer_email 'vasily@locomote.com'
license          'BSD'
description      'Installs Siege'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

%w{centos redhat ubuntu gentoo}.each do |os|
  supports os
end

depends 'yum'
