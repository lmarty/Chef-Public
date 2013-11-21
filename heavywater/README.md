Description
===========

Utility functions used by Heavy Water Software Inc.

1. Generate an authenticated S3 URL: auth_s3_url

Usage
=====

```ruby
include_recipe "heavywater"

class Chef::Recipe
  include HeavyWater
end

auth_s3_url( :aws_access_key_id => "some_key",
             :aws_secret_access_key => "some_secret",
             :bucket => "some_bucket",
             :object => "some_object",
             :seconds_to_expire => 60 )
```
