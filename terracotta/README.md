Description
===========

Installs the Terracotta clustering software. This cookbook is intended for
use with the Shibboleth IdP and has not been tested in other configurations.

Requirements
============

Platform
--------

Tested and developed on CentOS

Cookbooks
---------

Requires the stock java cookbook, and should probably only be used with our
Shibboleth IdP cookbook.

Attributes
==========

* `node["terracotta"]["version"]` - The version of the software we're
installing.  Should match the archive you place in files/default - see
`Usage` below.

* `node['terracotta']['install_dir']` - Where to unpack the software.
Defaults to `/opt/src`

* `node['terracotta']['tims']` - A dictionary of TIM names mapped to version
numbers.  For each one, you must place a matching jar file in
files/default/.  See `Usage`, below, for more information.  Defaults to what
you need to run Shibboleth - vector, tomcat-6.0, tomcat-5.5, tomcat-common,
session-common, and session-ui.

* `node['terracotta']['toolkits']` - A dictionary of toolkit major versions
mapped to minor versions.  For each one, you must place a matching jar file
in files/default/.  See `Usage`, below, for more information.  Defaults to
what you need to run Shibboleth - 1.6.

We support placing the tim and toolkit archives locally to faciliate
deployments with default-deny outbound firewalls.  We should probably make
it a configuration option whether to use a local copy or fetch them with
tim-get.sh.

Usage
=====

Place the Terracotta distribution tarball in the files/default/ directory of
this cookbook, along with any TIMs and/or toolkits you want to load.

Define at the `version` attribute to match the tarball you used above.

If you are using this cookbook with Shibboleth and Terracotta, also be sure
to set the ['tomcat']['java_options'] attribute to something like this:

-Dtc.install-root=/opt/terracotta -XX:+MustCallLoadClassInternal -Dtc.config=/opt/terracotta/tc-config.xml -Xbootclasspath/p:$TC_HOME/lib/dso-boot/dso-boot-hotspot_linux_160_29.jar -Xms1G -Xmx1G -XX:+UseParallelOldGC -XX:MaxGCPauseMillis=5000 -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:-TraceClassUnloading

License and Author
==================

Author:: Elliot Kendall (<elliot.kendall@ucsf.edu>)

Copyright:: 2013, The Regents of the University of California
