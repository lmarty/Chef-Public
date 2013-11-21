chef-multitail
==============

multitail Cookbook
==================

Install multitail on unix-based systems.


Requirements
------------

Mac OS X or Linux system


Attributes
----------

#### multitail::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['multitail']['check_mail']</tt></td>
    <td>Boolean</td>
    <td>whether to check mail on start up</td>
    <td><tt>false</tt></td>
  </tr>
</table>


Usage
-----
#### multitail::default

Just include `multitail` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[multitail]"
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


License and Authors
-------------------
Authors: Brett Richardson (dablweb.com) [github: brett-richardson]
