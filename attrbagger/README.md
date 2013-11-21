`attrbagger` Cookbook
=====================

Get attributes from data bags.

Somewhat fancy.

Requirements
------------

Attrbagger does not depend on any other cookbooks.  It works with both
`chef-solo` and `chef-client` by using `data_bag_item`.

Attributes
----------

#### `attrbagger::default`
<table>
  <tr>
    <th>Key</th><th>Type</th><th>Description</th><th>Default</th>
  </tr>
  <tr>
    <td><tt>node['attrbagger']['autoload']</tt></td>
    <td><tt>Boolean</tt></td>
    <td>
        Used when including the default recipe to decide whether or
        not to autoload attributes.
    </td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>node['attrbagger']['precedence_level']</tt></td>
    <td><tt>Boolean</tt></td>
    <td>
        The default precedence level to use when not specified in each
        <tt>Hash</tt> of <tt>node['attrbagger']['configs']</tt>.
    </td>
    <td><tt>:override</tt></td>
  </tr>
  <tr>
    <td><tt>node['attrbagger']['configs']</tt></td>
    <td><tt>Hash</tt></td>
    <td>
        The <tt>Hash</tt> structure requires unique string keys representing the
        targets of each merged "data bag cascade" in a <tt>::</tt>-separated
        format to denote nesting, e.g. <tt>first::second</tt>.  The value of
        each key must be a <tt>Hash</tt> with an optional <tt>precedence_level</tt>
        key (default <tt>override</tt>) and a required <tt>bag_cascade</tt> key.
        The value of the <tt>bag_cascade</tt> key must be an <tt>Array</tt> containing
        strings representing the cascade of attributes that will be
        loaded.  The only type of resource currently supported is
        <tt>data_bag_item</tt>, e.g.
        <tt>'bag_cascade' => ['data_bag_item[a::b]', 'data_bag_item[c::d]']</tt>.
    </td>
    <td><tt>{}</tt></td>
  </tr>
</table>

Usage
-----

Attrbagger may be used either as a library or by including the
`recipe[attrbagger::default]` in one's `run_list`.

When used as a library, the `Attrbagger` class may be used via its
`.autoload!` class method, or by creating a new instance and using the
`#load_config` instance method.  Both require injection of the
`run_context`, which is available in any recipe as `self.run_context`.
See the Attrbagger tests for more usage examples.

Inclusion of `recipe[attrbagger::default]` in the `run_list` will result
in the `node['attrbagger']['configs']` hash being walked and merged into
the node's attribute precedence level specified via each hash's
`precedence_level` attribute (defaulting to
`node['attrbagger']['precedence_level']`.

An example role using attrbagger to load application-specific
configuration from a base, custom, and dynamic environment-specific data
bag, as well as loading mail service configuration might look like this:

``` ruby

    name 'attrbagger_example'
    description 'Attrbagger example role'

    default_attributes(
      'deployment_env' => 'demo',
      'attrbagger' => {
        'configs' => {
          'example_app' => {
            'precedence_level' => 'override',
            'bag_cascade' => [
              'data_bag_item[applications::base::example_app]',
              'data_bag_item[applications::example_app]',
              "data_bag_item[applications::config_<%= node['deployment_env'] %>::example_app]"
            ]
          },
          'services::mail' => {
            'precedence_level' => 'default',
            'bag_cascade' => [
              'data_bag_item[services::mail]'
            ]
          }
        }
      },
      'example_app' => {
        'awesome' => true
      },
      'mail' => {
        'host' => 'localhost',
        'port' => 25
      }
    )

    run_list(
      'recipe[attrbagger]',
      # ... other stuff
    )

```

This would result in the following actions:

- Load `data_bag_item('applications', 'base')` and merge its `example_app`
hash with `node.default['example_app']`, then assign the result to
`node.override['example_app']`
- Load `data_bag_item('applications', 'example_app')` and merge the
entire data bag contents (except for builtin attributes like `id` and
`chef_type`) with `node.default['example_app']`, then assign the result
to `node.override['example_app']`.
- Load `data_bag_item('applications', 'config_demo')` and merge its `example_app`
hash with `node.default['example_app']`, then assign the result to
`node.override['example_app']`
- Load `data_bag_item('services', 'mail')` and merge the entire data bag
contents (except for builtin attributes like `id` and `chef_type`) with
`node.default['services']['mail']`, then assign the result to
`node.default['services']['mail']`.

Contributing
------------

[See CONTRIBUTING.md](https://github.com/modcloth-cookbooks/attrbagger/blob/master/CONTRIBUTING.md)

License
-------

[See LICENSE.md](https://github.com/modcloth-cookbooks/attrbagger/blob/master/LICENSE.md)

Authors
-------

[See AUTHORS.md](https://github.com/modcloth-cookbooks/attrbagger/blob/master/AUTHORS.md)
