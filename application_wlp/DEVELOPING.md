# Development

To work on the Liberty application cookbook first ensure you have [Bundler][] installed.

```bash
$ gem install bundler
```

Next, use [Bundler][] to install Liberty application cookbook dependencies:

```bash
$ bundle install
```

Finally, use [Rake][] to execute various tasks. For example:

```bash
$ rake all
```

[Bundler]: http://bundler.io/
[Rake]: http://rake.rubyforge.org/

# Testing

To check syntax of the cookbook files execute:

```bash
$ rake syntax
```

To run [Foodcritic][] (lint-like tool) on the cookbook execute:

```bash
$ rake foodcritic
```

To run [test-kitchen][] tests execute:

```bash
$ rake kitchen
```

In order to run the [test-kitchen][] tests you must first configure them. Please see [How to run 'test kitchen' tests](https://github.com/WASdev/ci.chef.wlp/wiki/How-to-run-%27test-kitchen%27-tests) for more information. The tests and cookbooks used by [test-kitchen][] are located in the **test/** directory. 


[Foodcritic]: http://acrmp.github.io/foodcritic/
[test-kitchen]: https://github.com/opscode/test-kitchen

