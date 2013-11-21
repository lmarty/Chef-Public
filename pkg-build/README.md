# Package Build

Provides definitions for building packages with Chef

## Usage

This is a wrapper cookbook that uses LWRPs for the likes
of fpm-tng and builder to generate packages. Include the
recipe in the run list and the package will be built.

```
run_list('recipe[pkg-build::ruby]')
```

## Notes

This is currently ubuntu only.

## Infos
* Repository: https://github.com/hw-cookbooks/pkg-build
* IRC: Freenode @ #heavywater
