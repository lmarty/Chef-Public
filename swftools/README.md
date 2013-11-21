# <a name="title"></a> chef-swftools [![Build Status](https://secure.travis-ci.org/fnichol/chef-swftools.png?branch=master)](http://travis-ci.org/fnichol/chef-swftools)

## <a name="description"></a> Description

Installs SWFTools: utilities for working with Adobe Flash files (SWF files).

## <a name="usage"></a> Usage

Simply include `recipe[swftools]` to install SWFTools.

## <a name="requirements"></a> Requirements

### <a name="requirements-chef"></a> Chef

Tested on 10.12.0 but newer and older version should work just fine.
File an [issue][issues] if this isn't the case.

### <a name="requirements-platform"></a> Platform

The following platforms have been tested with this cookbook, meaning that the
recipes run on these platforms without error:

* ubuntu

Please [report][issues] any additional platforms so they can be added.

### <a name="requirements-cookbooks"></a> Cookbooks

There are **no** external cookbook dependencies.

## <a name="installation"></a> Installation

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release
is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

### <a name="installation-platform"></a> From the Opscode Community Platform

To install this cookbook from the Opscode platform, use the *knife* command:

    knife cookbook site install swftools

### <a name="installation-librarian"></a> Using Librarian-Chef

[Librarian-Chef][librarian] is a bundler for your Chef cookbooks.
Include a reference to the cookbook in a [Cheffile][cheffile] and run
`librarian-chef install`. To install Librarian-Chef:

    gem install librarian
    cd chef-repo
    librarian-chef init

To use the Opscode platform version:

    echo "cookbook 'swftools'" >> Cheffile
    librarian-chef install

Or to reference the Git version:

    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'swftools',
      :git => 'git://github.com/fnichol/chef-swftools.git', :ref => 'v0.2.4'
    END_OF_CHEFFILE
    librarian-chef install

### <a name="installation-kgc"></a> Using knife-github-cookbooks

The [knife-github-cookbooks][kgc] gem is a plugin for *knife* that supports
installing cookbooks directly from a GitHub repository. To install with the
plugin:

    gem install knife-github-cookbooks
    cd chef-repo
    knife cookbook github install fnichol/chef-swftools/v0.2.4

### <a name="installation-tarball"></a> As a Tarball

If the cookbook needs to downloaded temporarily just to be uploaded to a Chef
Server or Opscode Hosted Chef, then a tarball installation might fit the bill:

    cd chef-repo/cookbooks
    curl -Ls https://github.com/fnichol/chef-swftools/tarball/v0.2.4 | tar xfz - && \
      mv fnichol-chef-swftools-* swftools

### <a name="installation-gitsubmodule"></a> As a Git Submodule

A dated practice (which is discouraged) is to add cookbooks as Git
submodules. This is accomplishes like so:

    cd chef-repo
    git submodule add git://github.com/fnichol/chef-swftools.git cookbooks/swftools
    git submodule init && git submodule update

**Note:** the head of development will be linked here, not a tagged release.

## <a name="recipes"></a> Recipes

### <a name="recipes-default"></a> default

Installs SWFTools.

### <a name="recipes-apt-repository"></a> apt_repository

Adds an apt repsitory (in Ubuntu) containing the swftools package. The
`default` recipe will include this recipe if needed.

## <a name="attributes"></a> Attributes

There are **no** configurable attributes in this cookbook.

## <a name="lwrps"></a> Resources and Providers

There are **no** resources and providers in this cookbook.

## <a name="development"></a> Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

## <a name="license"></a> License and Author

Author:: [Fletcher Nichol][fnichol] (<fnichol@nichol.ca>) [![endorse](http://api.coderwall.com/fnichol/endorsecount.png)](http://coderwall.com/fnichol)

Copyright 2011, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[chef_repo]:    https://github.com/opscode/chef-repo
[kgc]:          https://github.com/websterclay/knife-github-cookbooks#readme
[librarian]:    https://github.com/applicationsonline/librarian#readme

[fnichol]:      https://github.com/fnichol
[repo]:         https://github.com/fnichol/chef-swftools
[issues]:       https://github.com/fnichol/chef-swftools/issues
