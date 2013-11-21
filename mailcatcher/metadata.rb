name             "mailcatcher"
maintainer       "Chendil Kumar Manoharan"
maintainer_email "mkchendil@gmail.com"
license          "Apache 2.0"
description      "Installs mailcatcher"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"


%w{ suse}.each do |os|
  supports os
end

recipe "mailcatcher::default", "Installs mailcatcher"