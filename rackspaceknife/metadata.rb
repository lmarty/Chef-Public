name		 "rackspaceknife"
maintainer       "Gerald L. Hevener Jr., M.S."
maintainer_email "jackl0phty@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures rackspaceknife"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.10"

%w{ perl minitest-handler }.each do |ckbk|
  depends ckbk
end

%w{ ubuntu debian mint redhat centos amazon scientific oracle fedora arch }.each do |os|
  supports os
end
