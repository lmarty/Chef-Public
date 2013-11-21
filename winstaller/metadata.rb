maintainer       "Smashrun, Inc."
maintainer_email "support@smashrun.com"
license          "Apache 2.0"
description      "Installs/Configures Windows Installer 4.5 Redistributable"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.3"

depends          "powershell", ">= 1.0.6"

%w{ windows }.each do |os|
  supports os
end