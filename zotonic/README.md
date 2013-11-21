Zotonic Cookbook
================

This cookbook installs Zotonic in various ways.

Requirements
------------
This cookbook requires the `erlang` and `apt` cookbooks.


#### packages
- `imagemagick` - for image transformations
- `postgresql` - for database access

Attributes
----------

#### zotonic::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['zotonic']['install_method']</tt></td>
    <td>String</td>
    <td>The installation method that is used. Currently only method is "ppa".</td>
    <td><tt>n/a</tt></td>
  </tr>
</table>

Usage
-----
#### zotonic::default

Just include `zotonic` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[zotonic]"
  ]
}
```

License and Authors
-------------------
Authors: Arjan Scherpenisse; License: MIT
