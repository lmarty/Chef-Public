maintainer       "En Masse Entertainment"
maintainer_email "jamie@enmasse.com"
license          "Apache 2.0"
description      "Installs/Configures MogileFS"
long_description "Refer to README.md, it's too long to IO.read."
version          "0.2.5"

%w{ ubuntu }.each do |os|
  supports os
end

depends 'perl', '~> 0.10.0'
depends 'runit', '~> 0.14.2'
