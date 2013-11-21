jenkins_build Cookbook
======================
Build a complete Jenkins CI server

Requirements
------------
#### packages
- `apt`
- `postgresql`
- `jenkins`
- `nodejs`
- `phantomjs`
- `git`

Attributes
----------

e.g.
#### jenkins_build::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['jenkins_build']['packages']</tt></td>
    <td>Array</td>
    <td>Include required packages for gem prereqs</td>
    <td><tt>`libxml2-dev` `libxslt-dev`</tt></td>
  </tr>
  <tr>
    <td><tt>['jenkins_build']['jenkins_user_postgresql_password']</tt></td>
    <td>Array</td>
    <td>Only needed if using Chef Solo, configure password for postgres</td>
    <td><tt>thisshouldbechanged</tt></td>
  </tr>
</table>

Usage
-----
#### jenkins_build::default
Just include `jenkins_build` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[jenkins_build]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: John T Skarbek
