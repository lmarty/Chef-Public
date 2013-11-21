# resource-tester cookbook

# Requirements
Chef 10.16.2 or higher

# Motivation
With the release of 10.16.0, the community quickly found a rather serious bug.
(ticket CHEF-3547). The remote_file resource was not keeping it's
promises. After talking with Josh, I learned that there are plans to
exercise "reference" cookbooks during testing. I needed an excuse to learn minitest-chef, so I decided to
start the ultimate reference cookbook. It would exercise all the core Chef resources to make sure they
kept their basic contracts.

This cookbook is meant to act as a source of examples for writing
tests and cross platform design patterns.

Hopefully it will make it into the testing process.

# Usage

cd ~/src/resource-tester
bundle exec kitchen test

# Attributes
n/a (yet). Add some!

# Recipes
default.rb is a monolithic recipe for now.

# TODO
TONS. This is just a start. Right now, only the user, file (+cousins), and cron types are exercised.
It only works on centos.

My time to work on this is close to non-existent, so its continued
developement needs to be a community effort. Send pull requests!

The short list:
1) Add tests for packages and services
2) Refactor to be cross platform across ubuntu
3) Refactor again to work across all "supported" Chef platforms.
4) Devise a strategy for testing "through time". This is needed to
test general idempotence, long running node behavior in the face of package updates and
repo modifications, multi-phase convergence problems (see pki cookbook), etc.

# Author

Author:: Sean OMeara (<someara@opscode.com>)
