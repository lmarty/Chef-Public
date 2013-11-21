Description
===========

[PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/) is a free implementation of Telnet and SSH for Windows and Unix platforms, along with an xterm terminal emulator.

Requirements
============

Platform
--------

* Windows XP
* Windows Vista
* Windows Server 2003 R2
* Windows 7
* Windows Server 2008 (R1, R2)

Cookbooks
---------

* windows

Attributes
==========

* `node['putty']['home']` - location to install putty files to.  default is `%SYSTEMDRIVE%\putty`

Usage
=====

default
-------

Downloads and installs putty to the location specified by `node['putty']['home']`.  Also ensures `node['putty']['home']` is in the system path.


