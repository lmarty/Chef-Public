Description
===========

This cookbook provides an easy way to install Holland Backup.

More information?
http://hollandbackup.org

Requirements
============

## Cookbooks:

This cookbook doesn't have direct dependencies on other cookbooks.

## Platforms:

* Debian
* Ubuntu

Attributes
==========

* `node['hollandbackup']['distro']` - The Linux distro (Debian_5.0, Debian_Etch, xUbuntu_8.04, xUbuntu_9.04, xUbuntu_9.10, xUbuntu_10.04, xUbuntu_10.10), defaults to "xUbuntu_10.04"
* `node['hollandbackup']['backupsets']` - A list of backupsets
* `node['hollandbackup']['cron']['minute']` - The cron job's minute value
* `node['hollandbackup']['cron']['hour']` - The cron job's hour value
* `node['hollandbackup']['cron']['day']` - The cron job's day value
* `node['hollandbackup']['cron']['month']` - The cron job's month value
* `node['hollandbackup']['cron']['weekday']` - The cron job's weekday value

Usage
=====

1. include `recipe[hollandbackup]` in a run list
2. include `recipe[hollandbackup::holland-mysqldump]` to install holland-mysqldump
3. include `recipe[hollandbackup::main-config]`
4. include `recipe[hollandbackup::backupset-config]`
5. include `recipe[hollandbackup::cron]` to have cron run the command periodically
6. tweak the attributes via attributes/default.rb
	--- OR ---
	override the attribute on a higher level (http://wiki.opscode.com/display/chef/Attributes#Attributes-AttributesPrecedence)

References
==========

* [Holland Backup home page] (http://hollandbackup.org)
* [Holland Backup installation] (http://wiki.hollandbackup.org/Installation)
* [Holland Backup configuration] (http://docs.hollandbackup.org/config.html)

License and Authors
===================

Author: David Joos <david@escapestudios.com>
Author: Escape Studios Development <dev@escapestudios.com>
Copyright: 2012, Escape Studios

Author: David Joos <development@davidjoos.com>
Copyright: 2012-2013, David Joos

Unless otherwise noted, all files are released under the MIT license,
possible exceptions will contain licensing information in them.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.