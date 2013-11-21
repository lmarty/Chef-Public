Description
===========

[![Build Status](https://secure.travis-ci.org/realityforge/chef-gelf_handler.png?branch=master)](http://travis-ci.org/realityforge/chef-gelf_handler)

A cookbook that a handler that sends chef run results to a GELF server such as
Logstash or Graylog. If you have the [ohai-system_pacakges](https://github.com/finnlabs/ohai-system_packages/)
plugin installed, it will also send package statistics.

Requirements
============

The `chef_handler` cookbook.

Attributes
==========

This cookbook uses the following attributes to configure how it is installed.

* `node['chef_client']['handler']['gelf']['host']` - The gelf server host. Defaults to nil.
* `node['chef_client']['handler']['gelf']['port']` - The gelf server port. Defaults to 12201.
* `node['chef_client']['handler']['gelf']['facility']` - The facility under which to report. Defaults to 'chef-client'.
* `node['chef_client']['handler']['gelf']['report_host']` - The host to report messages as coming from. Defaults to `node['fqdn']`.
* `node['chef_client']['handler']['gelf']['blacklist']` - A hash of cookbooks, resources and actions to ignore in the change list.. Defaults to `{}`.

Usage
=====

Set the host and port properties on the node and include the "gelf_handler::default" recipe.

Blacklisting
------------

Some resources report themselves as having updated on every run even if nothing changed, or
are just things you don't care about. To reduce the amount of noise in your logs these can be
ignored by providing a blacklist. In this example we don't want to be told about the GELF handler
being activated:

  node['chef_client']['handler']['gelf']['blacklist'] =
     {"chef_handler" => {"chef_handler" => [ "nothing", "enable" ]}


Credits
=======

The handler was originally written by Jon Wood and was converted to a cookbook by Peter Donald.
