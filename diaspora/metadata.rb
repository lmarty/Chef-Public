maintainer       "Promet Solutions"
maintainer_email "marius@promethost.com"
license          "Apache 2.0"
description      "Installs/Configures diaspora"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1.0"

%w{ xml imagemagick git build-essential }.each do |cb|
  depends cb
end
%w{ ubuntu debian }.each do |os|
  supports os
end
