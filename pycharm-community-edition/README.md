pycharm-community-edition Cookbook
==================================
Installs PyCharm Community Edition

Requirements
------------
Currently it only supports installations on Windows. 
Attributes
----------
* `default['pycharm-community-edition']['windows']['package_name']`
    - Package name. Defaults to: 'PyCharm Community Edition'
* `default['pycharm-community-edition']['windows']['url']`
    - installation URL. Defaults to `'http://download.jetbrains.com/python/pycharm-community-3.0.exe'`

Usage
-----

Just include `pycharm-community-edition` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[pycharm-community-edition]"
  ]
}
```

Contributing
------------
To contribute:

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass.
6. Submit a Pull Request using Github

Note: You will need the latest version of ChefSpec from https://github.com/acrmp/chefspec.

License and Authors
-------------------
Authors: Rilindo Foster <rilindo.foster@monzell.com>
