# Description

A quick and easy way to manage system packages.

This package uses attributes or data bag metadata to
control package installation using the default system
package manager.

The motivation for this cookbook is to provide a quick
bootstrap for platforms that are not supported by most
published cookbooks (for my use this is FreeBSD and
Arch Linux). You can quickly build up a role from
system packages without the need to create lots of
single purpose cookbooks to install standard packages
on these systems.


# Requirements

## Chef

No specific version requirements. There are no external
dependencies. Tested on 11.4.0.

## Platform

The following platforms have been tested with this cookbook, meaning that the
recipes run on these platforms without error:

 * FreeBSD
 * Arch Linux
 * Ubuntu

# Installation

There are several ways you can install this cookbook.

### <a name="installation-platform"></a> From the Opscode Community Platform

To install this cookbook from the Opscode platform, use the *knife* command:

    knife cookbook site install package-driver

### <a name="installation-librarian"></a> Using Librarian-Chef

[Librarian-Chef][https://github.com/applicationsonline/librarian-chef]
is a bundler for your Chef cookbooks.  Include a reference to the
cookbook in a `Cheffile` and run `librarian-chef install`.

To reference the latest published version:

    cookbook 'package-driver', '>= 0.1.0'

To reference the github version:

    cookbook 'package-driver'
      :github => 'markhibberd/package-driver'

Then run:

    librarian-chef install

# Usage

Create items in the `packages` databag containing your package
listings, specify `recipe[package-driver]` in your run list and
populate the 'packages' attribue to indicate which `packages`
listings to install.

A basic `packages` data-bag item, `data_bags/packages/haskell.json`:

    {
      "id": "server",
       "packages": [
           "ghc",
           "cabal-install"
       ]
    }

A role demonstration:

    name 'demo'
    description 'Role for a demo node.'

    default_attributes 'packages' => [ 'server' ]

    run_list  'recipe[package-driver]'


# Recipes

## default

Install a list of packages, specified by data bag. The default data
bag is `packages`. And the list of items to install is set on
`node['packages']`.

# Attributes

## `data_bag`

Specify the name of the data bag to pull package information from, default `packages`.

## `items`

Specify the _name_ of the attribute to use to populate the package lists, default `packages`.

# Resources and Providers

None yet.

# Development And Issues

* [https://github.com/markhibberd/package-driver](https://github.com/markhibberd/package-driver)

* [Issues](https://github.com/markhibberd/package-driver/issues)

* [http://community.opscode.com/cookbooks/package-driver](http://community.opscode.com/cookbooks/package-driver)

The implementation is currently pretty sparse. There is a plan to add more in the near future. Any suggestions, issues or patches are very welcome.

# License and Author

Author:: Mark Hibberd <mark@hibberd.id.au>

Copyright:: 2013, Mark Hibberd

All code is copyright 2013 Mark Hibberd <mark@hibberd.id.au>

All code is licensed under a 3-point BSD style license.

See LICENSE or https://github.com/markhibberd/package-driver/blob/master/LICENSE.


## Related

 * [user](http://community.opscode.com/cookbooks/user) - Creates users from data bags using a similar process.
 * [dpkg_packages](http://community.opscode.com/cookbooks/dpkg_packages) - Installs debian packages using, among other things, data bags for specifying details.
