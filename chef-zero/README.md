Chef Zero Cookbook
==================
A cookbook for managing Chef Zero installation (as a service).

Recent version of Chef include Chef Zero, but this cookbook provides more flexibility and control over the version and allows you to start Chef Zero as a system service.

Installation
------------
Add `chef-zero` to your `Berksfile`:

```ruby
cookbook 'chef-zero', '~> 1.0'
```

Or you can install it directly with knife:

    $ knife cookbook site install chef-zero


Usage
-----
Add the cookbook to your `run_list` in a node or role:

```ruby
"run_list": [
  "recipe[chef-zero::default]"
]
```

Or include it in a recipe:

```ruby
# other_cookbook/metadata.rb
# ...
depends 'chef-zero'
```

```ruby
# other_cookbook/recipes/default.rb
# ...
include_recipe 'chef-zero::default'
```

Attributes
----------
<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Example</th>
      <th>Default</th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>version</td>
      <td>version of the chef-zero gem to install</td>
      <td><tt>1.3</tt></td>
      <td><tt>1.4</tt></td>
    </tr>
    <tr>
      <td>install</td>
      <td>install the chef-zero gem</td>
      <td><tt>false</tt></td>
      <td><tt>false</tt></td>
    </tr>
    <tr>
      <td>start</td>
      <td>start chef-zero as a system service</td>
      <td><tt>false</tt></td>
      <td><tt>false</tt></td>
    </tr>
    <tr>
      <td>daemon</td>
      <td>name of the daemon</td>
      <td><tt>fake-chef</tt></td>
      <td><tt>chef-zero</tt></td>
    </tr>
    <tr>
      <td>host</td>
      <td>the host to listen on</td>
      <td><tt>192.168.4.4</tt></td>
      <td><tt>0.0.0.0</tt></td>
    </tr>
    <tr>
      <td>listen</td>
      <td>the port or socket to listen on</td>
      <td><tt>/tmp/chef-zero.sock</tt></td>
      <td><tt>80</tt></td>
    </tr>
    <tr>
      <td>generate_real_keys</td>
      <td>generate real keys</td>
      <td><tt>false</tt></td>
      <td><tt>false</tt></td>
    </tr>
  </tbody>
</table>

License & Authors
-----------------
- Author:: Seth Vargo (<sethvargo@gmail.com>)

```text
Copyright 2013 Seth Vargo <sethvargo@gmail.com>
Copyright 2013 Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
