Description
===========
Installs and configures fusioninventory-agent on debian/ubuntu systems.

Requirements
============
apt

Attributes
==========

See the attributes/default.rb for default values

You will need to set the attribute server_url your compatible inventory server 

I recommend GLPI see http://www.glpi-project.org/spip.php?lang=en 
with the plugin for fusioninventory http://forge.fusioninventory.org/projects/fusioninventory-for-glpi
see the main http://www.fusioninventory.org/ there are other compatible servers as well.

Usage
=====

On node use the recipe, 
{ "run_list": ["recipe[fusioninventory-agent::default]"] }

Supported Platforms
===================
Debian / Ubuntu



Author:: Mat Davies
Cookbook Name:: fusioninventory-agent

Copyright 2012

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


