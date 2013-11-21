deployer
========
Set up a deploy user with the necessary ssh authorized keys. This is great for working with Capistrano where you need to deploy code, but it doesn't make sense for each user to have a shell account.

This cookbook will create a deployment user (`deploy` by default) **with passwordless-sudo permissions** for deployment. As a result, it is highly recommended that you disable password authentication and **only** support key-based authentication.

Requirements
------------
At this time, you must have a Unix-based machine. This could easily be adapted for Windows machines. Please submit a Pull Request if you wish to add Windows support.

Configuration
-------------
There are three attributes that you can override in your node:

- `node['deployer']['user']` - the name of the deploy user (default: `deploy`)
- `node['deployer']['group']` - the group for the deploy user (default: `deploy`)
- `node['deployer']['home']` - the home directory for the deploy user (default: `/home/deploy`)

### Adding keys
There are two ways to add keys to the `deployer`. If you're using the opscode `users` cookbook, `deployer` easily integrates with the existing `:users` data_bags. Simply add the `servers` key to an existing user:

```json
// data_bags/users/svargo.json
{
  "id": "svargo",
  "uid": "1000",
  "deploy": "any"
}
```

or specify an array of servers or IP addresses that the user should be allowed to deploy to:

```json
// data_bags/users/svargo.json
{
  "id": "svargo",
  "uid": "1000",
  "deploy": [
    "1.2.3.4",
    "mynode.example.com"
  ]
}
```

If you're not using the `users` cookbook, or if you have a conflict, you can use the `:deployers` data_bag instead:

Create the data_bag:

    knife data bag create deployers

Create a deployer:

```json
// data_bags/deployers/svargo.json
{
  "id": "svargo",
  "deploy": [
    "1.2.3.4",
    "mynode.example.com"
  ]
}
```

The same options apply to the `servers` key as above. **Note: this will not actually create system user accounts.**

Usage
-----
If you're using [Berkshelf](http://berkshelf.com/), just add `deployer` to your `Berksfile`:

```ruby
cookbook 'deployer'
```

Otherwise, install the cookbook from the community site:

    knife cookbook site install deployer

Have any other cookbooks *depend* on deployer by editing editing the `metadata.rb` for your cookbook.

```ruby
depends 'deployer'
```

Once you have the cookbook installed, add it to your node's `run_list` or `role`:

```ruby
"run_list": [
  "recipe[deployer]"
]
```

And override attributes as necessary:

```ruby
# mynode.example.com
"override_attributes": {
  "deployer": {
    "user": "apache",
    "group": "apache",
    "home": "/usr/bin/false"
  }
},
"run_list": [
  "recipe[deployer]"
]
```

Contributing
------------
1. Fork the project
2. Create a feature branch corresponding to you change
3. Commit and test thoroughly
4. Create a Pull Request on github
    - ensure you add a detailed description of your changes

License and Authors
-------------------
Authors: [Seth Vargo](https://github.com/sethvargo) ([@sethvargo](https://twitter.com/sethvargo))

Copyright 2012, Seth Vargo
