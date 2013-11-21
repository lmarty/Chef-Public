name             "vifm"
maintainer       "Greg Fitzgerald"
maintainer_email "greg@gregf.org"
license          "Apache 2.0"
description      "Installs vifm"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"
name             "vifm"

recipe "vifm::default",   "Installs the package or falls back to compiling from source"
recipe "vifm::source",    "Compiles vifm from source"
recipe "vifm::package",   "Installs the vifm package"

%w{ debian ubuntu centos fedora }.each do |os|
  supports os
end
