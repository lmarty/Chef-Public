Description
===========

This is a cookbook to build riemann, from http://riemann.io

Requirements
============

The cookbook should do the majority of it, but for the server you'll need java. For the clients you'll need ruby and ruby gems.

Attributes
==========

```ruby
default[:riemann][:ruby_tarball_location] = "http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p374.tar.gz"
default[:riemann][:ruby_tarball] = "ruby-1.9.3-p374.tar.gz"
default[:riemann][:ruby_tarball_dir] = "ruby-1.9.3-p374"

default[:riemann][:riemann_tarball_location] = "http://aphyr.com/riemann/riemann-0.2.0.tar.bz2"
default[:riemann][:riemann_install_location] = "/opt/riemann"
default[:riemann][:riemann_tarball] = "riemann-0.2.0.tar.bz2"
default[:riemann][:riemann_version] = "riemann-0.2.0"
```

Usage
=====

Add `riemann::server` to the run_list to install the server, this will also install the client.

Add `riemann::client` to the run_list to just install the client gem.

Add `riemann::dash` to the run_list to install the riemann-dashboard, which will install both the server and client.

