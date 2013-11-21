# rabbitmq_settings cookbook
[![Build Status](https://travis-ci.org/higanworks-cookbooks/rabbitmq_settings.png?branch=master)](https://travis-ci.org/higanworks-cookbooks/rabbitmq_settings)


Converge rabbitmq settings using lwrp. Depends on opscode-cookbook[rabbitmq].

## Platform

Will supposed to...

* ubuntu
* smartos

# Requirements

* opscode-cookbook[rabbitmq]

# Usage

This cookbook depends on cookbook[rabbitmq] from opscode-site.

Set vhosts or users to databag. And add recipe[rabbtmq_seggings::from_databag] to runilst.

# Attributes

* default['rabbitmq_settings']['databag_name'] = "rabbitmq"
  * Name of data bag for use.

# Recipes

## from_databag

Create rabbitmq vhost and users from data_bag.


### vhosts

Set name of vhost and action.

For example.  
Create vhosts `/one` and `/four`, and delete `/two` if exists.

`vhosts.json`
<pre><code>{
  "id": "vhosts",
  "vhosts": {
    "/one": "add",
    "/two": "delete",
    "/four": "add"
  }
}</code></pre>

### users

Set name of user and permissions for vhost.  
To clear permission for vhost, set nil to permission value.

For example.  
Create user `user_one` and set permission ".* .* .*" to vhost `/one`. 
Delete `user_two` if exists.  
Clear permission `usr_three` from vhost `/one`.

<code><pre>{
  "id" : "users",
  "users" : {
    "user_one" : {
      "password" : "pass",
      "action" : "add",
      "permissions" : {
         "/one" : "\\\".*\\\" \\\".*\\\" \\\".*\\\""
      }        
    },
    "user_two" : {
      "action" : "delete"
      },
    "user_three" : {
      "password" : "pass_three",
      "action" : "add",
      "permissions" : {
         "/one" : null
      }
    }
  }
}</code></pre>


# Test

## test-kitchen 

* kitchen test --platform ubuntu-12.04

## Foodcritic

* foodcritic ./

# Author

Author:: HiganWorks LLC (<sawanoboriyu@higanworks.com>)
