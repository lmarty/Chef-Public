OCLint Cookbook
===============

Install OCLint (http://oclint.org/) on your box.

Requirements
------------

Mac OS or Linux

Depends on `build-essential`, `git` and `python`.


Attributes
----------

TODO


Usage
-----

#### oclint::default

Just include `oclint` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[oclint]"
  ]
}
```

Vagrant
-------

Make sure [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus) is installed.

Run `vagrant up`.


License
-------

Uses the [MIT](http://opensource.org/licenses/MIT) license.
