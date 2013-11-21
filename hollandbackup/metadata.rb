name             "hollandbackup"
maintainer       "David Joos"
maintainer_email "development@davidjoos.com"
license          "MIT"
description      "Installs/Configures hollandbackup"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.7"

%w{ debian ubuntu }.each do |os|
supports os
end