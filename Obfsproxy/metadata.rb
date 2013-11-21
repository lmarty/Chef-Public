maintainer       "Dlshad Othman"
maintainer_email "dothman@internews.eu"
license          "Apache 2.0"
description      "Install obfsproxy server on Debian, Centos RedHat and Ubuntu"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.textile'))
version          "0.0.5"

%w{ ubuntu debian centos redhat }.each do |os|
  supports os
end
