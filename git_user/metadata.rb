name             'git_user'
maintainer       'Vasily Mikhaylichenko'
maintainer_email 'vaskas@lxmx.com.au'
license          'BSD'
description      'Git users configuration'
version          '0.3.0'

%w{redhat centos ubuntu gentoo}.each do |os|
  supports os
end

%w{user git ssh_known_hosts}.each do |d|
  depends d
end
