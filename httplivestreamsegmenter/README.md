Description
===========

This cookbook provides an easy way to install the HTTP live stream segmenter.

More information?
https://github.com/VRT-onderzoek-en-innovatie/HTTP-Live-Stream-Segmenter

Requirements
============

## Cookbooks:

* build-essential
* git

## Platforms:

* Ubuntu
* Debian

Attributes
==========

* `node['httplivestreamsegmenter']['prefix']` - Location prefix of where the installation files will go
* `node['httplivestreamsegmenter']['git_repository']` - Location of the source git repository
* `node['httplivestreamsegmenter']['git_revision']` - Revision of the git repository to install
* `node['httplivestreamsegmenter']['compile_flags']` - Array of flags to use in compilation process

Usage
=====

1) include `recipe[httplivestreamsegmenter]` in a run list
2) tweak the attributes via attributes/default.rb
	--- OR ---
	override the attribute on a higher level (http://wiki.opscode.com/display/chef/Attributes#Attributes-AttributesPrecedence)

References
==========

* [VRT onderzoek en innovatie HTTP-Live-Stream-Segmenter on github] (https://github.com/VRT-onderzoek-en-innovatie/HTTP-Live-Stream-Segmenter)

Changelog
=========

### 0.0.7
    * bugfix - delete creates immediately

### 0.0.6
    * only run compilation when creates file is not present
    * delete creates file when new source is available and/or compile flags have changed

### 0.0.5
    * don't run compilation more than necessary
    * upgrade libssl-dev package

License and Authors
===================

Author: David Joos <david@escapestudios.com>
Author: Escape Studios Development <dev@escapestudios.com>
Copyright: 2012-2013, Escape Studios

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