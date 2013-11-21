hg cookbook
===========
Cookbook wrapper around "mercurial" to add other possibilities.

Requirements
------------

#### packages
- `mercurial` - Official cookbook.

Attributes
----------

#### hg::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['hg']['repo']</tt></td>
    <td>String</td>
    <td>Can be "ppa"</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

Usage
-----
#### hg::default
Just include `hg` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[hg]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
7. Enjoy

License and Authors
-------------------
Author:: Guilhem Lettron <guilhem.lettron@optiflows.com>
