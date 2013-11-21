# <a name="title"></a> chgems Chef Cookbook

[![Build Status](https://travis-ci.org/fnichol/chef-chgems.png?branch=master)](https://travis-ci.org/fnichol/chef-chgems)

## <a name="description"></a> Description

Chef cookbook for [chgems][chgems], a chroot for RubyGems.

* Website: http://fnichol.github.io/chef-chgems/
* Opscode Community Site: http://community.opscode.com/cookbooks/chgems
* Source Code: https://github.com/fnichol/chef-chgems

## <a name="usage"></a> Usage

Simply include `recipe[chgems]` in your run\_list and chgems will be installed.

## <a name="requirements"></a> Requirements

### <a name="requirements-chef"></a> Chef

Tested on 11.4.4 but newer and older version should work just fine.
File an [issue][issues] if this isn't the case.

### <a name="requirements-platform"></a> Platform

The following platforms have been tested with this cookbook, meaning that the
recipes run on these platforms without error:

* ubuntu
* debian
* centos
* mac\_os\_x

Please [report][issues] any additional platforms so they can be added.

### <a name="requirements-cookbooks"></a> Cookbooks

This cookbook depends on the following external cookbooks:

* [ark][ark_cb]

## <a name="installation"></a> Installation

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release
is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

### <a name="installation-site"></a> From the Opscode Community Site

To install this cookbook from the Community Site, use the *knife* command:

    knife cookbook site install chgems

### <a name="installation-berkshelf"></a> Using Berkshelf

[Berkshelf][berkshelf] is a cookbook dependency manager and development
workflow assistant. To install Berkshelf:

    cd chef-repo
    gem install berkshelf
    berks init

To use the Community Site version:

    echo "cookbook 'chgems'" >> Berksfile
    berks install

Or to reference the Git version:

    repo="fnichol/chef-chgems"
    latest_release=$(curl -s https://api.github.com/repos/$repo/git/refs/tags \
    | ruby -rjson -e '
      j = JSON.parse(STDIN.read);
      puts j.map { |t| t["ref"].split("/").last }.sort.last
    ')
    cat >> Berksfile <<END_OF_BERKSFILE
    cookbook 'chgems',
      :git => 'git://github.com/$repo.git', :branch => '$latest_release'
    END_OF_BERKSFILE
    berks install

### <a name="installation-librarian"></a> Using Librarian-Chef

[Librarian-Chef][librarian] is a bundler for your Chef cookbooks.
To install Librarian-Chef:

    cd chef-repo
    gem install librarian
    librarian-chef init

To use the Community Site version:

    echo "cookbook 'chgems'" >> Cheffile
    librarian-chef install

Or to reference the Git version:

    repo="fnichol/chef-chgems"
    latest_release=$(curl -s https://api.github.com/repos/$repo/git/refs/tags \
    | ruby -rjson -e '
      j = JSON.parse(STDIN.read);
      puts j.map { |t| t["ref"].split("/").last }.sort.last
    ')
    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'chgems',
      :git => 'git://github.com/$repo.git', :ref => '$latest_release'
    END_OF_CHEFFILE
    librarian-chef install

## <a name="recipes"></a> Recipes

### <a name="recipes-default"></a> default

This recipe downloads and installs chgems.

## <a name="attributes"></a> Attributes

### <a name="attributes-version"></a> version

The version of chgems to install.

The default is `"0.3.2"`.

### <a name="attributes-url"></a> url

The URL from which to download and install chgems.

The default is `"https://github.com/postmodern/chgems/archive/v#{node['chgems']['version']}.tar.gz"`.

## <a name="lwrps"></a> Resources and Providers

There are **no** resources and providers.

## <a name="development"></a> Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

## <a name="license"></a> License and Author

Author:: [Fletcher Nichol][fnichol] (<fnichol@nichol.ca>) [![endorse](http://api.coderwall.com/fnichol/endorsecount.png)](http://coderwall.com/fnichol)

Copyright 2013, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[ark_cb]:       http://community.opscode.com/cookbooks/ark
[berkshelf]:    http://berkshelf.com/
[chef_repo]:    https://github.com/opscode/chef-repo
[cheffile]:     https://github.com/applicationsonline/librarian/blob/master/lib/librarian/chef/templates/Cheffile
[chgems]:       https://github.com/postmodern/chgems
[librarian]:    https://github.com/applicationsonline/librarian#readme

[fnichol]:      https://github.com/fnichol
[repo]:         https://github.com/fnichol/chef-chgems
[issues]:       https://github.com/fnichol/chef-chgems/issues

