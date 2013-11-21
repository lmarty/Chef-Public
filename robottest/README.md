Description
===========

Use this cookbook to distribute your tests to the target systems and run them there.

The cookbook has yet only been tested on / implemented for Debian/Ubuntu. Furthermore,
currenty it's currently not possible to include libs with pybot/jybot, but it's a
small thing and will be done in the next version. Of course, contribution is very
welcome.

Requirements
============

To use this cookbook, you need:

robot (with all its dependencies)

Attributes
==========

runner - "j" or "p" as in "jybot" / "pybot"  
urlbase - the HTTP base path where to get test archives from  
archive - the name of the tar.gz file which contains all test relevant files  
test - test spec file to run, relative to the .. of the tar base folder  

Usage
=====

What you can do with it? You need to know about acceptance test automation and how they
are implemented/supported by the Robot Framework. When you know this, you will also know
that acceptance tests can be very slow. If you have a chance to run parts of your whole
suites on different machines in parallel, this cookbook will help you do so.
