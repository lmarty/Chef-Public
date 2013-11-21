DESCRIPTION
===========

This cookbook is used to configure a system as a Tasseo server.

REQUIREMENTS
============

Chef 0.9.18 or later is required.

Supported Platforms
-------------------

The following platforms are supported by this cookbook, meaning that the recipes run on these platforms without error.

* Ubuntu

Other Cookbooks
---------------

Other cookbooks can be used with this cookbook but they are not explicitly required. The default settings in this cookbook do not require their use. The other cookbooks (on cookbooks.opsocde.com) are:

* runit

See __USAGE__ below.

ATTRIBUTES
==========

* `default[:tasseo][:home_dir]` - Sets the install directory
* `default[:tasseo][:dashboard_dir]` - Sets the location of your dashboard files
* `default[:tasseo][:log_dir]` - Sets the log directory. Default: "/var/log/tasseo".
* `default[:tasseo][:user]` - Sets the user that the tasseo service will run as. Default: "tasseo".
* `default[:tasseo][:run_state]` - Sets the run state of the runit service. Default: "start".
* `default[:tasseo][:port]` - Sets the tasseo port. Default: 5000.
* `default[:tasseo][:git_repo]` - Sets the tasseo git repo. Default: git://github.com:obfuscurity/tasseo.git.
* `default[:tasseo][:graphite_url]` - Sets the graphite url. Default: "localhost". You will want to change this.
* `default[:tasseo][:graphite_auth]` - Sets the graphite auth. Default: "username:changeme". You will want to change this.
* `default[:tasseo][:url]` - Sets the URL by which the Tasseo web interface will be accessed. Default: "tasseo.example.com". You will want to change this.

RECIPES
=======

This section describes the recipes in the cookbook and how to use them in your environment.

default
-------

Installs and configures the Tasseo service.

web
-------

Configures an nginx site and proxy for the Tasseo service.

USAGE
=====

Create a `tasseo_server` role that will represent the base configuration that includes managing aspects of the Tasseo server.

    name "tasseo_server"
    description "Tasseo Server"
    override_attributes(
      "tasseo" => {
        "url" => "tasseo.yourawesomedomain.com"
      }
    )
    run_list(
      "recipe[tasseo::default]",
      "recipe[tasseo::web]"
    )

TEMPLATES
=========

nginx-tasseo-conf.erb
----
Nginx config for the Tasseo web interface.

sv-tasseo-*run.erb
----

Runit run script for Tasseo service and logs.

Logs will be located in the `node["tasseo"]["log_dir"]`.


LICENSE AND AUTHORS
===================

* Author: Dan Ryan <dan@crowdflower.com>
* Copyright 2012, CrowdFlower, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
