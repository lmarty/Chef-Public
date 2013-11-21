lshw Cookbook
=============
Installs lshw, an hardware utility lister

Requirements
------------

Tested on Ubuntu and Fedora. May work in Debian. RHEL/CentOS requires EPEL/Repoforge repo.

Attributes
----------
- `default['lshw']['package_name']` = Package name. Defaults to `lshw`.


Installation
-----------
Install from community site or clone it from github.


Usage
-----

Just include `lshw` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[lshw]"
  ]
}
```

For CentOS and RHEL, you will need to include the yum::repoforge and/or yum::epel as well. Note that if you installed
from Opscode, you may need to exclude chef in repoforge and epel's repo.

Contributing
------------
To contribute:

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Rilindo Foster
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
