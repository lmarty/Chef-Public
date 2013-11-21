Description
===========

Use this cookbook to setup the robotframework (http://code.google.com/p/robotframework/) and
to distribute your tests to the target systems.

The cookbook has yet only been tested on / implemented for Debian/Ubuntu.

Requirements
============

To use this cookbook, you need:

apt
java
python

The rest (robotframework etc.) will be installed through its recipes.

Attributes
==========

robot.version - the version of the framework which will be downloaded and installed

Usage
=====

What you can do with it? You can install the robot framework with its all dependencies and
get ready to run distributed acceptance tests. Of course it's also possible to provision
robot to one single machine and run tests there.
