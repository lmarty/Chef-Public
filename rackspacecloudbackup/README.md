Description
===========

This cookbook provides an easy way to install the Rackspace Cloud Backup (RCBU) Agent.

More information?
* http://www.rackspace.com/knowledge_center/product-page/cloud-backup
* http://www.rackspace.com/knowledge_center/article/rackspace-cloud-backup-install-the-agent

Requirements
============

## Cookbooks:

This cookbook doesn't have direct dependencies on other cookbooks.

## Platforms:

* Debian
* Ubuntu
* RHEL
* CentOS
* Fedora

Attributes
==========

* `node['rackspacecloudbackup']['repository_key']` - The Rackspace Cloud Backup Agent repository key, defaults to "F6A5034C"
* `node['rackspacecloudbackup']['username']` - Your Rackspace Cloud username
* `node['rackspacecloudbackup']['api_key']` - Your Rackspace Cloud API key

Usage
=====

1)
include `recipe[rackspacecloudbackup]` in a run list

2)
	change the `node['rackspacecloudbackup']['username']` and `node['rackspacecloudbackup']['api_key']` attributes
	--- OR ---
	override the attribute on a higher level (http://docs.opscode.com/essentials_cookbook_attribute_files.html#Attributes-AttributesPrecedence)

References
==========

* [Rackspace Cloud Backup support] (http://www.rackspace.com/knowledge_center/product-page/cloud-backup)
* [Rackspace Cloud Backup - install the agent] (http://www.rackspace.com/knowledge_center/article/rackspace-cloud-backup-install-the-agent)

Changelog
=========

* https://github.com/djoos/chef-rackspacecloudbackup/commits/master

License and Authors
===================

Author: David Joos <development@davidjoos.com>
Copyright: 2013, David Joos

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