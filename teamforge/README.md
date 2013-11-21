Description
===========

Installs and configures CollabNet TeamForge Server or the command line client.

Requirements
============

TeamForge Server is supported on the following platforms:

* RedHat Enterprise Linux 6.x
* CentOS 6.x
* SuSE Linux Enterprise Server 11

Attributes
==========

See `attributes/default.rb` for default values.

server
------

* node['teamforge']['server']['public_site_name'] - The public hostname of your TeamForge server (e.g. "teamforge.example.com")
* node['teamforge']['server']['local_features'] - Features to run on the local TeamForge server.
* node['teamforge']['server']['version'] - The version of TeamForge to install
* node['teamforge']['server']['install_dir'] - Where TeamForge is installed
* node['teamforge']['server']['scm_default_shared_secret'] - The SCM shared secret used by SCM integrations. If not set, a random one will be generated and saved to the node object.
* node['teamforge']['server']['listen_ports'] - Ports to open to the public, for use in the iptables firewall rule

codesight
---------

* node['teamforge']['codesight']['public_site_name'] - The public hostname of your Black Duck Code Sight server
* node['teamforge']['codesight']['ssl'] - Whether to enable SSL with Black Duck Code Sight.

cli
---

* node['teamforge']['cli']['frsid'] - The CollabNet FRS ID where the cli tools are located. If not set, automatically determines based on the host architecture.
* node['teamforge']['cli']['checksum'] - Checksum of the foregoing
* node['teamforge']['cli']['url'] - The URL to retrieve the CLI from

The CLI recipe will also set up a basic .ctf_cli preferences file pointing to your TeamForge server, using the following attributes:

* node['teamforge']['cli']['api_url'] - The SOAP API URL (typically the same as the public site URL for your TeamForge server)
* node['teamforge']['cli']['api_alias'] - The SOAP API alias in the .ctf_cli
* node['teamforge']['cli']['api_user'] - The API USER
* node['teamforge']['cli']['api_password'] - A hash of the API password

Recipes
=======

default
-------

Does nothing.

server
------

Installs the TeamForge Server from RPMs in unattended mode.

codesight
---------

Installs Black Duck Code Sight on the TeamForge server, or another server (doesn't have to be on the same box as TeamForge itself)

cli
---

Installs the CLI tool to interact with TeamForge's SOAP API.

License and Author
==================

Author:: Julian Dunn (<jdunn@opscode.com>)

Copyright:: 2013, Opscode, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
