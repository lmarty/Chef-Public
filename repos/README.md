Description
===========

Manages repositories for your platform. Currently only Debian-based
distributions are supported.

Simple repository source can be described via node attributes. If you
need more complicated setup you can use separate recipes, some are
supplied with this cookbook.

Platform
============

* Debian/Ubuntu

Attributes
==========

* node['repos'] - List of repositories to be activated by default
  recipe. Can be either recipe name to be included or attributes hash.
  The keys in each hash correspond to the attributes passed to the
  repository resource. Attribute 'type' defines which repository
  resource will be used, but only 'apt' is supported now.

Usage
=====

If repository is defined in a separate recipe you may either add it
directly to run_list, include from your wrapper-cookbook or use
data-driven approach and enumerate desired repos in 'repos' attribute
anywhere you want.

When you just need to add simple package source without additional
actions like pinning, just add attribute hash describing repo in
node["repos"] list.

Example use of run_list:

    run_list("recipe[repos::percona]")

Example use of 'repos' attribute

    run_list("recipe[repos]")
    override_attributes( "repos" => ['jenkins-debian-glue', 'backports'] )

Example use of repo hash:

    "repos" => ['jenkins-debian-glue',
      { 'type' => "apt",
        'name' => "nginx-1.2.6",
        'uri'  => "http://ci.clodo.ru/release/nginx-1.2.6",
        'distribution' => "nginx-1.2.6",
        'components' => ["main"]
      },
    ]

TODO
====

* Databags support
