name             'loco_xvfb'
maintainer       'Locomote'
maintainer_email 'vasily@locomote.com.au'
license          'BSD'
description      'Installs and configures xvfb as a service'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3'

%w{centos ubuntu}.each do |os|
  supports os
end

recommends 'yum'
