Description
===========

Install a Cloud Foundry RabbitMQ gateway or node, optional components of a
[Cloud Foundry](http://www.cloudfoundry.org) installation.

Requirements
============

Cookbooks
---------

* cloudfoundry
* cloudfoundry\_service
* rbenv

Platform
--------

* Ubuntu

Tested on:

* Ubuntu 10.04
* Ubuntu 12.04

Attributes
==========

gateway
-------

* `node['cloudfoundry_rabbitmq_service']['gateway']['log_level']` - Log level for
the service gateway daemon. Defaults to `info`.
* `node['cloudfoundry_rabbitmq_service']['gateway']['node_timeout']` - Time out
for talking to a service node. Defaults to `30`.
* `node['cloudfoundry_rabbitmq_service']['gateway']['timeout']` - Time out for
completing (de)provisioning requests. Defaults to `15`.
* `node['cloudfoundry_rabbitmq_service']['gateway']['ip_route']` - The IP address
of a host that will be used to determine the correct IP address to use to
talk to other components; or `nil` to use the default. Defaults to `nil`.
* `node['cloudfoundry_rabbitmq_service']['node']['check_orphan_interval']` -
Interval in seconds between checks for orphan service instances; set to -1 to
only check on request. Defaults to `-1`.
* `node['cloudfoundry_rabbitmq_service']['node']['double_check_orphan_interval']` -
After a succesful first check for orphans, a second check will be run; this
attribute determines the delay before this second check. Defaults to `300`.
* `node['cloudfoundry_rabbitmq_service']['gateway']['max_nats_payload']` - Maximum
size in bytes of a single announcement; bigger ones will be split into
multiple messages. Defaults to `1048576`.

node
----

* `node['cloudfoundry_rabbitmq_service']['node']['log_level']` - Log level for
the service node daemon. Defaults to `info`.
* `node['cloudfoundry_rabbitmq_service']['node']['index']` - Unique instance
info; should be configured to be different between nodes. Defaults to `0`.
* `node['cloudfoundry_rabbitmq_service']['node']['capacity']` - Maximum number
of service instances for this node. Defaults to `200`.
* `node['cloudfoundry_rabbitmq_service']['node']['port_range']['first']` -
The lower end of a range of ports that can be used for services nodes.
Defaults to `10001`.
* `node['cloudfoundry_rabbitmq_service']['node']['port_range']['last']` -
The higher end of a range of ports that can be used for services nodes.
Defaults to `20000`.
* `node['cloudfoundry_rabbitmq_service']['node']['admin_port_range']['first']` -
The lower end of a range of ports that can be used for the admin interface
of services nodes. Defaults to `20001`.
* `node['cloudfoundry_rabbitmq_service']['node']['admin_port_range']['last']` -
The higher end of a range of ports that can be used for the admin interface
of services nodes. Defaults to `30000`.
* `node['cloudfoundry_rabbitmq_service']['node']['migration_nfs']` - Path to
a directory that will be used when dumping and reimporting a node. Defaults
to `/mnt/migration`.
* `node['cloudfoundry_rabbitmq_service']['node']['max_clients']` - Maximum
number of clients that can connect to the service.. Defaults to `1000`.
* `node['cloudfoundry_rabbitmq_service']['node']['max_memory_factor']` -
Maximum percentage of memory to use. Defaults to `0.5`.
* `node['cloudfoundry_rabbitmq_service']['node']['ip_route']` - The IP address
of a host that will be used to determine the correct IP address to use to
talk to other components; or `nil` to use the default. Defaults to `nil`.
* `node['cloudfoundry_rabbitmq_service']['node']['z_interval']` - Frequency
in seconds between updating and announcing "varz" (i.e. service status
information). Defaults to `30`.
* `node['cloudfoundry_rabbitmq_service']['node']['max_nats_payload']` - Maximum
size in bytes of a single announcement; bigger ones will be split into
multiple messages. Defaults to `1048576`.
* `node['cloudfoundry_rabbitmq_service']['node']['fqdn_hosts']` - If true,
service bindings credentials will be issued using the hostname. If false,
the IP address will be used instead.. Defaults to `false`.
* `node['cloudfoundry_rabbitmq_service']['node']['op_time_limit']` - Maximum
time to wait during provisioning. Defaults to `6`.

Usage
=====

You need exactly one RabbitMQ service gateway, ideally deployed to the same
node as the `cloud_controller`:

    run_list: "recipe[cloudfoundry-rabbitmq-service::gateway]"

You can run as many RabbitMQ service nodes as needed to support your expected
work load:

    run_list: "recipe[cloudfoundry-rabbitmq-service::node]"

You also need to install the RabbitMQ package itself. You may want to provide
your own binaries, or you can use the simplified recipe in this cookbook:

    run_list: "recipe[cloudfoundry-rabbitmq-service::install22]",
              "recipe[cloudfoundry-rabbitmq-service::node]"

License and Author
==================

Author:: Andrea Campi (<andrea.campi@zephirworks.om.com>)

Copyright:: 2012-2013 ZephirWorks

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
