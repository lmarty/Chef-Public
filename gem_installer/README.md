Gem Installer
=============

Simple cookbook for managing gem versions on a node.

Usage
=====

Attributes
----------

Define gems (and optionally version restrictions) within the role:

```ruby
  override_attributes(
    :gem_installer => {
      :gems => {
        'pg' => nil,
        'activerecord' =>  '~> 3.0.0',
        'ssmtp' => nil
      }
    }
  )
```

Chef Gems
---------

Managing chef gems works in just same way, but by using the :chef_gems key
instead of :gems

```ruby
  override_attributes(
    :gem_installer => {
      :chef_gems => {
        'pg' => nil
      }
    }
  )
```

Backwards Compatibility
-----------------------

Use the [chef_gem]{http://community.opscode.com/cookbooks/chef_gem} cookbook to 
maintain compatibility on node running Chef pre 0.10.9

Issues/Bugs/Feature Requests
----------------------------

Create a github issue or fork, fix and send me a pull request

