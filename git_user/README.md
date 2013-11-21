# git_user

## Description

This cookbook features:

* A Chef LWRP to configure:
	* git `config.name` and `config.email`
	* a git-specific private ssh key
	* known ssh hosts
* A companion recipe for [user::data_bag](https://github.com/fnichol/chef-user) which adds the aforementioned configuration.

## Usage

Include `recipe[git_user]` in your `run_list` and `git_user` resource will become available.

The `git_user::data_bag` recipe assumes that you're using the `user::data_bag` recipe from the excellent [user cookbook](https://github.com/fnichol/chef-user). It lets you configure git-related aspects in user specific data_bags, e.g.

```
{
  "id"       : "testman",
  "home"     : "/home/testman"
  ...
  "git_user" : {
  	"enabled"    : true,
  	"full_name"  : "Test Man Jr.",
  	"email"      : "testman@test.com",
  	"private_key": "ABC123",
  	"known_hosts": ["github.com"]
  }
}
```

## Requirements


### Platform
This cookbook has been [tested](https://github.com/lxmx/chef-oh-my-zsh/blob/master/.kitchen.yml) with the following OSes:

* centos / redhat
* ubuntu
* gentoo

### Cookbooks
The cookbook has got the following dependencies:

* [user](https://github.com/fnichol/chef-user)
* [git](https://github.com/opscode-cookbooks/git)
* [ssh_known_hosts](https://github.com/opscode-cookbooks/ssh_known_hosts)

## Recipes

### default

No-op, does nothing.

### data_bag
Processes `node['users']` and performs the configuration for the ones whose data_bags enable it, e.g.

```
{ 
  "id"        : "ranger",
  ...
  "git_user" : { "enabled": true, "email": "ranger@solarsystems.io" }
}
```

## Resources and Providers

### git_user

#### Actions

<table>
  <thead>
    <tr>
      <th>Action</th>
      <th>Description</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>create</td>
      <td>Creates <code>.gitconfig</code> and/or configures the ssh key and known hosts.
      </td>
      <td>Yes</td>
    </tr>
  </tbody>
</table>

#### Attributes

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Default Value</th>
      <th>Required</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>login</td>
      <td><b>Name attribute:</b> The login of the user.</td>
      <td><code>nil</code></td>
      <td>yes</td>
    </tr>
    <tr>
      <td>home</td>
      <td>User's home directory.</td>
      <td><code>/home/<i>username</i></code> or <code>/root</code></td>
      <td>no</td>
    </tr>
    <tr>
      <td>full_name</td>
      <td>A value for git <code>config.name</code></td>
      <td><code><i>username</i></code></td>
      <td>no</td>
    </tr>
    <tr>
      <td>email</td>
      <td>A value for git <code>config.email</code></td>
      <td><code>"<i>username</i>@#{node['fqdn']}"</code></td>
      <td>no</td>
    </tr>
	<tr>
      <td>private_key</td>
      <td>A private SSH key to use for git, will be created as <code>/home/<i>username</i>/.ssh/git_user_rsa</code></td>
      <td><code>nil</code></td>
      <td>no</td>
    </tr>
	<tr>
      <td>known_hosts</td>
      <td>Hosts which the <code>private_key</code> will be used with</td>
      <td><code>[]</code></td>
      <td>yes if <code>private_key</code> is specified</td>
    </tr>
  </tbody>
</table>


#### Example

```
git_user 'charlie' do
  private_key get_my_super_secret_key
  known_hosts %w{ github.com bitbucket.org }
end

git_user 'bob' do
  full_name   'Bob McAllister'
  email       'bob@example.com'
end
```

## License

Copyright:: Vasily Mikhaylichenko and LxMx.

Licensed under BSD license.

    http://opensource.org/licenses/BSD-2-Clause