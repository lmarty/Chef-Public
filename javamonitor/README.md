Description
===========

Manages JavaMonitor applications through REST API.

---
Requirements
============

Platform
--------

Only tested on Ubuntu.

Cookbooks
---------

* webobjects
* build-essential

---
Attributes
==========

* `node[:javamonitor][:base_url]` - URL to JavaMonitor application
* `node[:javamonitor][:password]` - Access password for JavaMonitor.

---
Recipes
=======

default
-------

Does nothing.

---
Actions
=====

javamonitor_instance
-----

### Actions
Action  | Description 			| Default
------- | ------------                  | --------
create  | Creates a new instance        | Yes
stop    | Stops instance                | 
delete  | Deletes instanc               | 



javamonitor_application
-----

### Actions
Action  | Description 			| Default
------- | ------------                  | --------
create  | Creates application           | Yes



License and Authors
===================

Author:: Jedrzej Sobanski <jsobanski@lgi.com>

Copyright:: 2013, Liberty Global.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
