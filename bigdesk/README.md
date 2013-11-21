Description
===========

This is a simple cookbook to install bigdesk with chef.

bigdesk is a web front end for system infos about an elasticsearch cluster.

provide info about:

+ Global info about indices, field and filter caches
+ JVM details
+ OS details

provides charts:

+ Size of Field and Filter Caches
+ File Descriptors and Open Channels
+ JVM threads
+ JVM Heap and non-heap memory
+ OS CPU
+ OS Mem
+ OS Swap
+ User can switch between nodes in the cluster, new nodes are added and old nodes are removed automatically on the fly.

On top of that it is possible to set refresh interval and time window for the charts (no limits, 1 minute, 5 minutes, … etc)

Supports elasticsearch 0.17.x and 0.18.x

To immediately connect to a particular host, add the host, port, and go parameters to the query string: index.html?host=search.example.com&port=9200&go

Requirements
============

Platform
--------

* Debian, Ubuntu

Cookbooks
---------

* elasticsearch
* apache2

Usage
=====

Download the sources, unpack and upload with 'knife cookbook upload bigdesk'.

Simply include the recipe where ever you would like bigdesk installed.

    name "bigdesk"
    description "Install bigdesk from source"
    run_list(
      "recipe[bigdesk]"
    )

License and Author
==================

Author:: Sebastian Wendel

Copyright:: 2012, SourceIndex IT-Services

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
