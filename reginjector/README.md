Description
===========

It is a straightforward exercise to manage windows registry changes by either exporting or just writing out the registry changes to templates and then using a batch file wrapper around regedit to inject them into the registry.  Updates to the registry files will cause them to be reinjected.  Batch file was necessary for early versions of chef and windows; later versions of chef and windows work with the new "batch" resource.

Requirements
============

This cookbook does not have any other dependencies than regedit.  It should work on all versions of windows, without exception.  Versions of this cookbook prior to 0.2.0 did not work properly with 64bit windows OS'; however, that has been fixed with Chef version 11.6.0+ and reginjector >= 0.2.0.

Attributes
==========

Minimal.  I deploy a small number of registry changes across the board, and they are stored in an attribute array on the nodes.

Usage
=====

Add the default recipe to your run_list.  Add appropriately formatted .reg files to the templates directory, and then update the payload array to deploy them.
