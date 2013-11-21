name             "sauceconnect"
maintainer       "Opscode, Inc"
maintainer_email "jdunn@opscode.com"
license          "Apache 2.0"
description      "Installs/Configures SauceLabs Connect Proxy"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.10"

%w{fedora redhat centos oracle amazon scientific}.each do |p|
  supports p
end

depends "java"
