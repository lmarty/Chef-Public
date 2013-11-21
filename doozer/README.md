# <a name="title"></a>Doozer Chef Recipe

## <a name="description"></a>Description

Manages [doozerd][1], a highly available, consistent, distrbuted data store, and
associated client libraries.

## <a name="installation"></a> Installation

[Librarian][2] is a cookbook dependency manager which will _take over_ your
_entire_ cookbooks directory. It is used here to demonstrate, along with [Vagrant][3]
and [VirtualBox][4], how you can use [Chef][5] to provision a virtual machine that
consists of [Doozer][1] and its dependencies.

To install all of your *RubyGem* dependencies:
        cd chef-doozer
        bundle install

To install all of your *Chef cookbook* dependencies:
        cd chef-doozer
        bundle exec librarian-chef install

## <a name="repository"></a> Git repository

The [git repository][5] is available. Please submit any pull requests with new
functionality!

[1]: https://github.com/ha/doozer "GitHub Doozer"
[2]: https://github.com/applicationsonline/librarian-chef "GitHub Librarian"
[3]: http://vagrantup.com "Vagrant"
[4]: http://virtualbox.org "VirtualBox"
[5]: https://github.com/johnbellone/chef-doozer "GitHub Chef Doozer"
