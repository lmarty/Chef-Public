name             "base"
maintainer       "Alexey Noskov"
maintainer_email "alexey.noskov@gmail.com"
license          "MIT"
description      "Configures basic server parameters: hostname, timezone, kernel modules."
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.1.0"

recipe "base", "Configure all parameters"
recipe "base::hostname", "Configure node hostname"
recipe "base::modules", "Configure node modules"
recipe "base::timezone", "Configure node timezone"

supports "ubuntu"
