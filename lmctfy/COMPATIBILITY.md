## chef-lmctfy Compatibility ##

### Installation Compatibility ###

Cookbook compatibility based on platform and installation type (`node['lmctfy']['install_type']`)

#### Source ####

Cookbook Compatibility

LMCTFY Version | CentOS 6 | Fedora 17 | RHEL 6 | Ubuntu 12.04 | Ubuntu 12.10 | Ubuntu 13.04 | Ubuntu 13.10
---------------|----------|-----------|--------|--------------|--------------|--------------|-------------
0.1.0          | -        | -         | -      | -            | 0.1+         | 0.1+         | 0.1+

Test Matrix

LMCTFY Version | CentOS 6 | Fedora 17 | RHEL 6 | Ubuntu 12.04 | Ubuntu 12.10 | Ubuntu 13.04 | Ubuntu 13.10
---------------|----------|-----------|--------|--------------|--------------|--------------|-------------
0.1.0          | -        | -         | -      | -            | 0.1+         | 0.1+         | 0.1+

### LWRP Compatibility ###

LWRP compatibility based on LMCTFY features.

#### Container ####

LMCTFY Command | Cookbook Version
---------------|-----------------
create         | 0.2+
destroy        | 0.2+
detect         | -
enter          | -
killall        | 0.2+
list           | -
notify         | -
run            | 0.2+
stats          | -
