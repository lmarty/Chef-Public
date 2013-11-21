Description
===========

This is a simple cookbook to install elasticsearch-head with chef.

elasticsearch-head is a web front end for browsing and interacting with an Elastic Search cluster.

* A ClusterOverview, which shows the topology of your cluster and allows you to perform index and node level operations
* A couple of search interfaces that allow you to query the cluster a retrieve results in raw json or tabular format
* Several quick access tabs that show the status of the cluster
* An input section that allows arbitrary call to the RESTful API to be made. This interface includes several options that can be combined to produce interesting results;
* Select request method (get, put, post, delete), json query data, node, and path
* JSON validator
* Ability to repeat requests on a timer
* Ability to transform the result using javascript expressions
* Ability to collect results over time (using timer), or compare results
* Ability to chart the transformed results in a simple bar graph (including time series)

*caution*, you can destroy and corrupt data from this interface if you are not careful

es-head will attempt to remember the node that it connects to using html5 features, however this only works over http(s).
If you would like to create a link to a particular cluster use the url form .../elasticsearch-head/index.html?base_uri=http://cluster.example.com:9200/

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

Download the sources, unpack and upload with 'knife cookbook upload elasticsearch-head'.

Simply include the recipe where ever you would like elasticsearch-head installed.

    name "elastichead"
    description "Install elasticsearch-head from source"
    run_list(
      "recipe[elasticsearch-head]"
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
