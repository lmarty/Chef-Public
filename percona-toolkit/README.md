# chef-percona_toolkit

## Description

Chef cookbook for installing [Percona toolkit](http://www.percona.com/software/percona-toolkit/)

## Requirements

The following platforms are supported by this cookbook and have been tested:

* CentOS
* Debian
* Red Hat
* Ubuntu

### Cookbooks

* [apt](http://community.opscode.com/cookbooks/apt) Opscode LWRP Cookbook
* [yum](http://community.opscode.com/cookbooks/yum) Opscode LWRP Cookbook

## Recipes

* `percona-toolkit` - Default recipe includes `percona-toolkit::package_repo` and does the package install.
* `percona-toolkit::package_repo` - Sets up the package repo.

## Usage

Include `recipe["percona-toolkit"]` in your run list, or add it to a role.

## License

Author:: Derek Schultz (<dschultz@brinkster.com>)

Copyright:: 2012, Derek Schultz

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.