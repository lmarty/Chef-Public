name              "re2"
maintainer       "Jordi Llonch"
maintainer_email "llonchj@gmail.com"
license          "All rights reserved"
description      "Installs/Configures re2"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w(build-essential mercurial).each do |dep|
  depends dep
end

%w(ubuntu centos fedora).each do |sup|
  supports sup
end
