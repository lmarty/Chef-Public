Description
===========

Configures a builder account for building and hosting deb packages
with Freight and Freightyard.

See https://github.com/3ofcoins/freightyard for more details on the
build script.

This cookbook sets up only the builder. Serving the repository and
configuring the clients is left as an exercise to the reader.

This cookbook is maintained at
https://github.com/3ofcoins/chef-cookbook-freightyard/

Requirements
============

* freight
* perl

Attributes
==========

* `user`, `group`, `user_home_dir` ("freightyard", "freightyard",
  "/srv/freightyard") - parameters of system account to configure
  builder for. You may want to change it to use Freightyard with a
  continuous integration system like Jenkins or Buildbot.
* `root_dir` ("/srv/freightyard") - root dir for freight config & work
  files. Freight config is `root_dir/freight.conf`, lib dir is
  `root_dir/lib`, cache dir (which is apt repository that you want to
  serve out) is `root_dir/cache`.
* `gpg_email`, `gpg_real_name` ("freightyard@#{node['fqdn']}",
  "Freightyard") - identity of generated GPG key.
* `archs`, `origin`, `label` ("i386 amd64", "Freight", "Freight") -
  parameters of apt repository.
* `script_revision` ("master") - revision of freightyard script to
  download from Github. Master is stable branch.

Usage
=====

