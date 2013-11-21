komodo-edit Cookbook
====================
Installs Komodo Editor


Requirements
------------
Supports Windows and Ubuntu >= 12.04.

Attributes
----------

Ubuntu:

* `default['komodo-edit']['package_name']` -
    - Name of Ubuntu apackage. Defaults to `komodo-edit`


Windows:

* `default['komodo-edit']['windows']['package_name']`
    - Name of windows package. Defaults to `'Komodo Editor'`.
    
* `default['komodo-edit']['windows']['url']`
    - URL to MSI package. Defaults to `'http://downloads.activestate.com/Komodo/releases/8.5.0/Komodo-Edit-8.5.0-13638.msi'`

Usage
-----

Just include `komodo-edit` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[komodo-edit]"
  ]
}
```

Contributing
------------
If you want to contribute:

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Rilindo Foster <rilindo.foster@monzell.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
