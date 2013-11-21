# This is a simple key/value pairing consisting of an OLD PACKAGE NAME
# for the key, and NEW PACKAGE NAME(s) for the value. This is useful when
# upgrading this cookbook and updated recipes have modified generated
# package names that are still in use (like ruby version tagged
# rubygem packages)
default[:pkg_build][:meta_mappings] = {}
