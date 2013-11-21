maintainer        "Bryan W. Berry"
maintainer_email  "bryan.berry@gmail.com"
license           "Apache 2.0"
description       "Installs and configures nagios client and runs under xinetd"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.0"

recipe "nagios-xinetd::default", "Installs and configures a nagios client with nrpe"

%w{ build-essential xinetd }.each do |cb|
  depends cb
end

%w{ debian ubuntu redhat centos fedora scientific}.each do |os|
  supports os
end
