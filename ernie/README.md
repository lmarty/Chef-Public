Description
===========
Install Ernie (https://github.com/mojombo/ernie) A.K.A. smoke

supports rhel, scientific, centos

Requirements
============
* Erlang
* ruby-dev{el}
* ruby
* rubygems

Attributes
==========
```
ernie.gem_binary = nil # The gem_binary for ernie to use to install the ernie gem
```

```
ernie.ruby = "package" # The method to install ruby requirements
```

Usage
=====

```
{
  "run_list": { "recipe[ernie]" }
}
```
