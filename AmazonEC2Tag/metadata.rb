maintainer       "CITYTECH, Inc."
maintainer_email "support@ctmsp.com"
license          "Apache 2.0"
description      "Chef LWRP for setting Amazon Web Services EC2 Tags."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "1.0.0"
recipe           "AmazonEC2Tag","Example implementation of the Chef LWRP for setting Amazon Web Services EC2 Tags."

%w{redhat centos debian ubuntu}.each do |os|
  supports os
end