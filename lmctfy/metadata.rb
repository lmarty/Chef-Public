# encoding: utf-8
name              'lmctfy'
maintainer        'Brian Flad'
maintainer_email  'bflad417@gmail.com'
license           'Apache 2.0'
description       "Installs/Configures Google's Let Me Contain That For You"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.2.1'
recipe            'lmctfy', 'Installs/Configures lmctfy'
recipe            'lmctfy::cgroups', 'Installs/Configures cgroups'
recipe            'lmctfy::lmctfy_init', 'Runs lmctfy init'
recipe            'lmctfy::source', 'Installs lmctfy source'
recipe            'lmctfy::source_cli', 'Installs lmctfy CLI via source'
recipe            'lmctfy::source_cpp', 'Installs lmctfy C++ via source'

%w{ubuntu}.each do |os|
  supports os
end

%w{apt build-essential control_groups gflags git protobuf re2}.each do |cb|
  depends cb
end
