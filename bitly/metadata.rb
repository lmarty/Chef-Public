maintainer       "Smashrun, Inc."
maintainer_email "support@smashrun.com"
license          "Apache 2.0"
description      "Installs/Configures bitly link shortner gem"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ centos redhat fedora ubuntu debian arch windows }.each do |os|
  supports os
end