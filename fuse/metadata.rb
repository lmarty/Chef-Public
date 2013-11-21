name             'fuse'
maintainer       'Rilindo Foster'
maintainer_email 'rilindo.foster@monzell.com'
license          'Apache 2.0'
description      'Installs/Configures fuse'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'
%W{ubuntu fedora}.each do |os |
  supports os
  case os
    when 'fedora', 'centos','rhel'
      depends 'yum'
    when 'ubuntu', 'debian'
      depends 'apt'
  end
end
