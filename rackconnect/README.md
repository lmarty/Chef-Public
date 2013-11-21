Description
===========

This cookbook will setup sudo and the sudoers files to allow rackconnect to do its thing.

Mostly useful if you have other chef cookbooks/recipes that edit/manage sudoers.

Requirements
============

You will need the [sudo](http://ckbk.it/sudo) cookbook.

Usage
=====

You NEED to enable (set to true) the `/etc/sudoers.d/` attribute (default is false):

    node['authorization']['sudo']['include_sudoers_d']

Then just include the recipe `rackconnect`.