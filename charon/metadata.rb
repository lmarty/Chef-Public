maintainer       "Smashrun, Inc."
maintainer_email "support@smashrun.com"
license          "Apache 2.0"
description      "Installs/Configures Microsoft SQL Server 2008+ Azure Data Sync Agent and Pre-requisites (dotnet4, dotnet4.5)"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

depends           "winstaller", ">= 0.0.6"

%w{ windows }.each do |os|
  supports os
end