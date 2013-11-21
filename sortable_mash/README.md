SortableMash
============

This cookbook provides a #sorted_hash method to Mash and Attribute instances. In 
many situations a configuration file is generated via JSON.pretty_generate or some 
other method using a Hash. The #sorted_hash option ensures that hashes are in a 
consistent order so file contents are not changed simply due to value reordering.

Ruby 1.8
--------

On system using a Ruby < 1.9, the orderedhash gem will be installed and used for
generating the Hash.

Support for chef_gem?
---------------------

Cooked in.

Cookbook Info
=============

Repo: https://github.com/chrisroberts/cookbook-sortable_mash
