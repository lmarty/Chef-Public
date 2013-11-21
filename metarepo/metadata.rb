maintainer       "Heavy Water Operations, LLC"
maintainer_email "ops@hw-ops.com"
license          "Apache 2.0"
description      "Installs/Configures metarepo"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends "git"
depends "ubuntu"
depends "ruby_installer"
depends "runit"
depends "openssl"
depends "database"
depends "postgresql"
depends "redis"

