Travis-ci status: [![Build Status](https://secure.travis-ci.org/jackl0phty/opschef-cookbook-zone2ldif.png?branch=master)](http://travis-ci.org/jackl0phty/opschef-cookbook-zone2ldif)


zone2ldif Cookbook
==================

This cookbook installs zone2ldif, a Perl script that converts a DNS zone file to an LDIF file, to /usr/local/bin/zone2ldif.pl..

Requirements
------------
Should work on any platform that the Perl cookbook supports.

Attributes
----------
There are no attributes in this cookbook.

Usage
-----
Just include `zone2ldif` in your node's `run_list`:
<pre><code>
{
  "name":"my_node",
  "run_list": [
    "recipe[zone2ldif]"
  ]
}
</pre></code>

Contributing
------------

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request on Github [here] (https://github.com/jackl0phty/opschef-cookbook-zone2ldif/issues)

License and Authors
-------------------
Author: Gerald L. Hevener Jr., M.S. aka:jackl0phty 
