maintainer       "Liberty Global"
maintainer_email "jsobanski@libertyglobal.com"
license          "Apache 2.0"
description      "Maintains JavaMonitor applications and instances life"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.7.0"

depends "webobjects"
depends "build-essential"

recipe "javamonitor", "Does nothing"

provides "javamonitor_application"
provides "javamonitor_instance"

supports "ubuntu"
