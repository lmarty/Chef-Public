name 'pkg-build'
maintainer 'Heavy Water'
maintainer_email 'support@hw-ops.com'
description 'Recipes for building packages'

version '0.2.2'

supports 'ubuntu'

depends 'builder'
depends 'fpm-tng', '~> 0.1.4'
depends 'reprepro', '~> 0.3.0'
depends 'apt', '>= 1.8.2'
depends 'ohai'
depends 'discovery', '>= 0.2.0'
depends 'lxc', '~> 1.0.0'
depends 'delayed_evaluator'
depends 'repository'
