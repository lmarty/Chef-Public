name             'minidlna'
maintainer       'Kannan Manickam'
maintainer_email 'me@arangamani.net'
license          'Apache 2.0'
description      'Installs/Configures minidlna'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.1.0'

%w{ ubuntu debian redhat centos fedora scientific }.each do |os|
  supports os
end

recipe 'minidlna', 'Installs and configures minidlna'
