# lxmx_oh_my_zsh
[![Build Status](https://travis-ci.org/lxmx/chef-oh-my-zsh.png?branch=master)](https://travis-ci.org/lxmx/chef-oh-my-zsh)

## Description

This cookbook features:

* A Chef LWRP to install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) for system users.
* A companion recipe for [user::data_bag](https://github.com/fnichol/chef-user) which adds an oh-my-zsh per user installation option.

## Usage

Include `recipe[lxmx_oh_my_zsh]` in your `run_list` and `lxmx_oh_my_zsh_user` resource will become available.

The `lxmx_oh_my_zsh::data_bag` recipe assumes that you're using the `user::data_bag` recipe from the excellent [user cookbook](https://github.com/fnichol/chef-user). It lets you configure oh-my-zsh installation in user specific data_bags, e.g.

```
{
  "id"        : "testman",
  "home"      : "/home/testman"
  ...
  "oh-my-zsh" : { "enabled": true, "theme": "wedisagree", "plugins": ["git", "rvm"] }
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
* [ark](https://github.com/bryanwb/chef-ark/)
* zsh

## Recipes

### default

No-op, does nothing.

### data_bag
Processes `node['users']` and installs oh-my-zsh for the ones whose data_bags enable it, e.g.

```
{
  "id"        : "ranger",
  ...
  "oh-my-zsh" : { "enabled": true }
}
```

## Resources and Providers

### lxmx_oh_my_zsh_user

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
      <td>ensure</td>
      <td>
        Install only if <code>~/.oh-my-zsh</code> or <code>~/.zshrc</code> is missing.
      </td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>update</td>
      <td>
        Install oh-my-zsh into <code>~/.oh-my-zsh</code>, create and populate <code>~/.zshrc</code>.
      </td>
      <td>No</td>
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
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>login</td>
      <td><b>Name attribute:</b> The login of the user.</td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>home</td>
      <td>User's home directory.</td>
      <td><code>/home/<i>username</i></code> or <code>/root</code></td>
    </tr>
    <tr>
      <td>theme</td>
      <td>Theme to use</td>
      <td><code>alanpeabody</code></td>
    </tr>
    <tr>
      <td>plugins</td>
      <td>Plugins to enable</td>
      <td><code>[]</code></td>
    </tr>
	<tr>
      <td>case_sensitive</td>
      <td>Use case sensitive completion</td>
      <td><code>false</code></td>
    </tr>
	<tr>
      <td>autocorrect</td>
      <td>Use autocorrection feature</td>
      <td><code>true</code></td>
    </tr>
  </tbody>
</table>

#### Example

```ruby
lxmx_oh_my_zsh_user 'jessie' do
  plugins        %w{git ruby}
  autocorrect    false
  case_sensitive true
end
```

## License

Copyright:: Vasily Mikhaylichenko and LxMx.

Licensed under BSD license.

    http://opensource.org/licenses/BSD-2-Clause
