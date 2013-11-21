maintainer       "Arun Tomar"
maintainer_email "arun@solutionenterprises.co.in"
license          "Apache 2.0"
description      "Installs/Configures skype"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe "skype","Installs and configures skype for centos & redhat"

%w{ centos redhat}.each do |os|
  supports os
end
