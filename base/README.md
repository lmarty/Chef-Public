# chef-base

## Description

Configures basic server parameters: hostname, timezone, kernel modules.

## Requirements

### Supported Platforms

The following platforms are supported by this cookbook, meaning that the recipes run on these platforms without error:

* Ubuntu

## Recipes

* `base` - Configure all parameters
* `base::hostname` - Configure node hostname
* `base::modules` - Configure node modules
* `base::timezone` - Configure node timezone

## Usage

Set your options in role/node and add recipe to run_list.

## Attributes

```ruby
default[:hostname] = nil
default[:timezone] = 'Etc/UTC'
default[:modules]  = []
```

## TODO


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contributors


## License

**chef-base**

* Freely distributable and licensed under the [MIT license](http://alno.mit-license.org/).
* Copyright (c) 2012 Alexey Noskov (alexey.noskov@gmail.com) [![endorse](http://api.coderwall.com/alno/endorsecount.png)](http://coderwall.com/alno)
