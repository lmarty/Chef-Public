# the_silver_searcher cookbook

Builds [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
from source.

# Requirements

Requires the `build_essential` cookbook. This cookbook only supports Debian,
Red Hat and SUSE platform families at this time.

# Usage

Include `recipe[the_silver_searcher]` in a run list.

# Attributes

* `[:the_silver_searcher][:version]` = version number to install
* `[:the_silver_searcher][:checksum]` = checksum of tar.gz source for this version

# Recipes

* default - installs The Silver Searcher to `/usr/local/bin/ag`

# Author

Author:: Mark Cornick (<mark@teamsnap.com>)

# Flair

[![Build Status](https://secure.travis-ci.org/teamsnap/the_silver_searcher-cookbook.png)](http://travis-ci.org/teamsnap/the_silver_searcher-cookbook)
