Travis-ci status: [![Build Status](https://secure.travis-ci.org/jackl0phty/opschef-cookbook-pvpgn.png?branch=master)](http://travis-ci.org/jackl0phty/opschef-cookbook-pvpgn)

DESCRIPTION:
============
This cookbook will automatically install and configure [PvPGN] (http://pvpgn.berlios.de/) (Player vs. Player Gaming Network).

PvPGN is based on bnetd and supports emulation of the following games:

* StarCraft
* Diablo II
* Diablo II LoD
* Warcraft III
* Tiberian Sun
* Red Alert 2
* Yuri's Revenge

REQUIREMENTS:
=============
After applying the pvpgn::default recipe to your new game server, you'll also need to install the BnetEditor
on your client machine. This is required so you can add the Ip address of your new game server as a new
Battle.net gateway. Otherwise your client won't be able to find your game server. You can down load
BnetEditor [here] (http://www.gamesperu.com/component/option,com_remository/Itemid,26/func,startdown/id,12/).

There are also several attributes you'll want to override in a role with values relevant to your environment.

WORKING GAMES:
==============
The following games have been tested and known to work with the latest version of the PvPGN cookbook.

* Diablo II LOD (Lords of Destruction) expansion set.

ATTRIBUTES:
===========
Supported db types: none|mysql|pgsql
<pre><code>
default['pvpgn']['db_type'] = "mysql"
</pre></code>
Set to 'yes' to install latest version from source
<pre><code>
default['pvpgn']['install_latest_from_source'] = "no"
</pre></code>
Set conf dir. /etc/pvpgn if pvpgn is installed
via package manager. /opt/pvpgn/etc if installed
from source.
<pre><code>
default['pvpgn']['conf_dir'] = "/etc/pvpgn"
</pre></code>
Set the following to configure a Diablo II closed realm server

-------------- Configure d2cs.conf ------------------
<pre><code>
default['pvpgn']['realmname'] = "D2CS"
</pre></code>

Set realm type
<pre><code>
default['pvpgn']['lod_realm'] = "2"
</pre></code>

WARNING!! DO NOT USE "127.0.0.1" or "localhost" !!!
<pre><code>
default['pvpgn']['d2cs_servaddrs'] = "0.0.0.0:6113"
</pre></code>

YOU MUST CHANGE THIS OR D2CS WON'T WORK PROPERLY
WARNING!! DO NOT USE "127.0.0.1" or "localhost" !!!
<pre><code>
default['pvpgn']['d2cs_gameservlist'] = "<d2gs-IP>,<another-d2gs-IP>"
</pre></code>

YOU MUST CHANGE THIS OR D2CS WON'T WORK PROPERLY
WARNING!! DO NOT USE "127.0.0.1" or "localhost" !!!
<pre><code>
default['pvpgn']['bnetdaddr'] = "<bnetd-IP>:6112"

default['pvpgn']['d2cs_loglevels'] = "fatal,error,warn,info,debug,trace"
</pre></code>
---------------End configure of d2cs.conf------------------


----------------- Configure realm.list --------------------

YOU MUST CHANGE THIS OR D2CS WON'T WORK PROPERLY
<pre><code>
default['pvpgn']['reaml_list'] = "\"D2CS\"\t\t\t\t\"PvPGN Closed Realm\"\t\t\t\t1.2.3.4:6113"
</pre></code>
---------------End configure of realm.list ------------------

------------------ Configure d2dbs.conf----------------------

Only necessary if using MySQL or PostgreSQL
WARNING!! DO NOT USE "127.0.0.1" or "localhost" !!!
<pre><code>
default['pvpgn']['d2dbs_servaddrs'] = "0.0.0.0:6114"
</pre></code>

YOU MUST CHANGE THIS OR D2DBS WON'T WORK PROPERLY
WARNING!! DO NOT USE "127.0.0.1" or "localhost" !!!
<pre><code>
default['pvpgn']['d2dbs_gameservlist'] = "<d2gs-IP>,<another-d2gs-IP>"

default['pvpgn']['d2dbs_loglevels'] = "fatal,error,warn,info,debug,trace"
</pre></code>

USAGE:
======
Below is a sample role to aadd to your node's .json config file.
<pre><code>
name "pvpgn_game_server"
description ""
run_list "recipe[pvpgn]"
override_attributes "pvpgn" => { "realmname" => "My Awesome Realm!!", "d2cs_servaddrs" => "192.168.10.10",
								 "d2cs_gameservlist" => "192.168.10.10",
								 "bnetdaddr" => "192.168.10.10", "d2cs_loglevels" => "fatal,error,warn,info,debug,trace",
								 "reaml_list" => "\"My awesome Realm!\"\t\"My Closed Realm\"\t192.168.10.10",
								 "d2dbs_servaddrs" => "192.168.10.10", "d2dbs_gameservlist" => "192.168.10.10",
								 "d2dbs_loglevels" => "fatal,error,warn,info,debug,trace", "lod_realm" => "1" }
</pre></code>

Add the role to the run list of your server's .json config file like so:
<pre><code>
"run_list": [
		    "role[pvpgn_game_server]"
],
</pre></code>

Upload the role to your Chef server or the Opscode platform like so:
<pre><code>
knife role from file roles/pvpgn_game_server.rb
</pre></code>

Re-run chef-client on your node, as root or via sudo, to update it's config like so:
<pre><code>
chef-client
</pre></code>

