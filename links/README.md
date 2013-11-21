links Cookbook
==============
Installs the links, a text browser.


Requirements
------------
Tested on Fedora and Ubuntu. It is fairly universal, so it should work without requiring an additiona repo.

Attributes
----------
`default['links']['package_name']`=  Package name. Defaults to `"links"`

Usage
-----

Just include `links` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[links]"
  ]
}
```


Contributing
------------
If you like to contribute:

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Rilindo Foster

you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0



