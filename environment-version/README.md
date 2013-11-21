# environment-version cookbook

As of Chef 11.6, environments are not able to be versioned. This cookbook
provides a library function that lets you maintain versioning information
in your environments file.

This is probably more of a hack than a good solution. But, it solves my
problem for now.

# Requirements

Be aware of the following constraints when using chef environments:

* Chef solo only supports environments in 11.6+
* Vagrant only supports environments in 1.3+

# Usage

You set the version attribute in your environment file like so:

    name "test"
    description "Test environment"

    default_attributes(
  
      :environment_version => 3,
    
      # other attributes go here
    )
    
In your cookbook's metadata.rb, add

    depends "environment-version"
    
And in your recipe, add

    environment_version_ensure(
      :production => 3,
      :test => 4
    )

See the test directory for a working example.

# Author

Author:: Dustin Spicuzza (dustin@virtualroadside.com)
