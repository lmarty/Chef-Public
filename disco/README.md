Description
===========

Installs the Disco map-reduce framework using the default settings.

Requirements
============

It is possible that earlier versions of these cookbooks will work as well.
These are the versions with which I've tested the cookbook.

* python >= 1.0.6
* simple_iptables >= 0.1.0
* build-essential >= 1.0.0

Platforms
=========

The cookbook is tested and works on Debian 6.0 and later. It may also work
on other platforms, but the templates are set up for Debian SysV init-type
systems. Contributions to support other platforms are gladly welcomed.

Attributes
==========

* `disco`
    * `repository` - URL to Git repository with Disco source code to clone
      and install. Default: "https://github.com/discoproject/disco.git"
    * `revision` - Revision to check out from within the `repository`.
      Default: "0.4.2" (tag)
    * `checkout` - Directory to clone `repository` into. Default:
      "/usr/src/disco"
    * `user`, `group`: User and group to run Disco as. Cookbook assumes
      that the user and group already exist. _Note: a default SSH
      configuration will be generated for the user, as Disco requires
      passwordless SSH key access between the master and slaves._ Default:
      "disco" (for both)
    * `slave_search`: A Chef search query which will identify nodes that are
      configured to be Disco slaves. Default: "recipes:disco".
* `erlang`
    * `magic_cookie`: Value to use as an Erlang magic cookie. This value
      must be the same on all Disco nodes (master and slaves). Default:
      "set_me_to_something_random"

Usage
=====

The cookbook includes an SSH key pair -- note that since this is published
publicly, deploying this keypair to a running, world-accessible cluster is
insecure! You should overwrite `files/default/id_rsa` and
`files/default/id_rsa.pub` with a matching, private keypair and take steps
to ensure that the private key is not publicly disclosed.

The cookbook has two recipes: `default` and `master`.

`default` Recipe
----------------

The `default` recipe clones and installs the Disco source. This recipe
should be used on Disco slave nodes.


`master` Recipe
---------------

The `master` recipe includes `default`, and configures and starts a Service
for running the Disco master node. This recipe additionally configures the
Disco master via "/usr/local/var/disco/disco_8989.config", a JSON
configuration file for the Disco cluster, based on a node search. It may
take several Chef runs for the search to stabilize, and the Disco master
will be restarted each time this templated file changes.

Changes
=======

* 0.1.2 (May 25, 2012)
    * Corrected an invalid `not_if`
* 0.1.1 (May 25, 2012)
    * Added warning about SSH keypair included in cookbook
    * Fixed foodcritic warnings
* 0.1.0 (May 12, 2012)
    * Initial release

