# Apticron Cookbook

[![Build Status](https://travis-ci.org/gregf/cookbook-apticron.png?branch=master)](https://travis-ci.org/gregf/cookbook-apticron)

Provides a chef cookbook that installs [apticron](http://www.debian-administration.org/articles/491).

##Requirements

###Chef

Tested on chef 11

###Platforms

* Debian
* Ubuntu

## Installation

### Cookbook Installation

Install the cookbook using knife:

    $ knife cookbook install apticron

Or install the cookbook from github:

    $ git clone git://github.com/gregf/cookbook-apticron.git cookbooks/apticron
    $ rm -rf cookbooks/apticron/.git

Or use the [knife-github-cookbooks](https://github.com/websterclay/knife-github-cookbooks) plugin:

    $ knife cookbook github install gregf/cookbook-apticron

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Author:: Greg Fitzgerald (greg@gregf.org)

Copyright:: Copyright (c) 2013 Greg Fitzgerald

License:: Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
