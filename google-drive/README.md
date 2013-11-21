google-drive Cookbook

This installs google-drive on workstation or server.

Requirements
------------
Aside from the requirements for google-drive itself, this cookbook works with Windows. A Mac OS X will be out in the near future.

Attributes
----------
* `default['google-drive']['windows']['package_name']` = Package name for Google Drive. Defaults to  `'Google Drive'`
* `default['google-drive']['windows']['url']` = URL of installer. Defaults to `'https://dl.google.com/drive/gsync_enterprise.msi'`

Usage
-----
#### google-drive::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `google-drive` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[google-drive]"
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

