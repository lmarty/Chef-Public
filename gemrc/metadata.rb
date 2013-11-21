name              'gemrc'

maintainer        'OptimisCorp., Inc.'
maintainer_email  'ops+cookbooks@optimiscorp.com'

license           'Apache 2.0'

description       'Configures rubygems to skip RI and RDoc installation.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version           '0.0.1'

recipe            'gemrc::default', 'Configures rubygems to skip RI and RDoc installation.'

%w{redhat centos scientific fedora debian ubuntu arch freebsd amazon}.each do |os|
  supports os
end
