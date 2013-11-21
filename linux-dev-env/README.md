Travis-ci status: [![Build Status](https://secure.travis-ci.org/jackl0phty/opschef-cookbook-linux-dev-env.png?branch=master)](http://travis-ci.org/jackl0phty/opschef-cookbook-linux-dev-env)

Description
===========

The primary focus of this cookbook will be preparing a GNU/Linux desktop/laptop/workstation/etc for various
types of Development.  The initial focus will be on Android and lua. At some point, Arm Assembly on the
Raspberry Pi.

Supported Development Environments
==================================

* Android
* Lua

Supported platforms
===================

This cookbook has only been tested on Linux Mint, my development platform of choice.
However, should work on Debian and Ubuntu.

Requirements
============

Create a role and apply it to your node's definition like so:
<pre><code>
name "android_dev"
description "Configure a GNU/Linux desktop/laptop for Android development "
run_list "recipe[linux-dev-env::android]"
override_attributes "linux-dev-env" => { "android_user" => "skywalker",
					 "android_group" => "skywalker" }
</pre></code>

The above code creates a role named 'android_dev', applies the linux-dev-env::android
recipe to your node, and sets the 'android_user' and 'android_group' to 'skywalker'.
This is the uid/gid of the user you plan on doing Android development under.

Next use knife to upload your 'android_role' like so:
<pre><code>
knife role from file roles/android_dev.rb
</pre></code>

Now create your node's definition in the /nodes directory like so:
<pre><code>
{
    "normal": {
    },
    "name": "skywalker-laptop",
    "chef_environment": "test",
    "override": {
    },
	"test": {
    },
    "json_class": "Chef::Node",
    "automatic": {
    },
    "run_list": [
	"role[android_dev]",
	"recipe[linux-dev-env::eclipse]",
	"recipe[linux-dev-env::java]"
    ],
    "chef_type": "node"
}
</pre></code>

The above code defines your node's definition, adds it to a test environment, applies your android_dev role, and 
also applies recipes linux-dev-env::eclipse & linux-dev-env::java.

The linux-dev-env::eclipse will install the latest version of the 'classic' version of the popular Eclipse IDE.

The linux-dev-env::java recipe will install Sun Java 6u37 and set it as the default Java via update-alternatives.
 
Next apply your new node definition against your node like so:
<pre><code>
laptop / # chef-client
[Tue, 30 Oct 2012 17:01:12 -0400] INFO: *** Chef 10.12.0 ***
[Tue, 30 Oct 2012 17:01:17 -0400] INFO: Run List is [role[android_dev], recipe[linux-dev-env::eclipse], recipe[linux-dev-env::java]]
[Tue, 30 Oct 2012 17:01:17 -0400] INFO: Run List expands to [linux-dev-env::android, linux-dev-env::eclipse, linux-dev-env::java]
[Tue, 30 Oct 2012 17:01:17 -0400] INFO: Starting Chef Run for laptop
[Tue, 30 Oct 2012 17:01:17 -0400] INFO: Running start handlers
[Tue, 30 Oct 2012 17:01:17 -0400] INFO: Start handlers complete.
[Tue, 30 Oct 2012 17:01:20 -0400] INFO: Loading cookbooks [linux-dev-env]
[Tue, 30 Oct 2012 17:01:23 -0400] INFO: Processing script[download-android-sdk] action run (linux-dev-env::android line 9)
[Tue, 30 Oct 2012 17:01:23 -0400] INFO: Processing script[untar-android-sdk] action run (linux-dev-env::android line 21)
[Tue, 30 Oct 2012 17:01:23 -0400] INFO: Processing script[set-permissions-on-android-sdk] action run (linux-dev-env::android line 33)
[Tue, 30 Oct 2012 17:01:23 -0400] INFO: Processing package[ia32-libs] action install (linux-dev-env::android line 44)
[Tue, 30 Oct 2012 17:01:24 -0400] INFO: Processing execute[download-eclipse-ide-x86_64_classic] action run (linux-dev-env::eclipse line 26)
[Tue, 30 Oct 2012 17:01:24 -0400] INFO: Processing script[install Java 6 JDK] action run (linux-dev-env::java line 11)
[Tue, 30 Oct 2012 17:01:24 -0400] INFO: Processing script[set-sun-java-as-default] action run (linux-dev-env::java line 28)
[Tue, 30 Oct 2012 17:01:24 -0400] INFO: script[set-sun-java-as-default] ran successfully
[Tue, 30 Oct 2012 17:01:25 -0400] INFO: Chef Run complete in 7.36495 seconds
[Tue, 30 Oct 2012 17:01:25 -0400] INFO: Running report handlers
[Tue, 30 Oct 2012 17:01:25 -0400] INFO: Report handlers complete
laptop etc #
</pre></code>

Where to go From Here
=====================

* If you made it this far you probably want to download and enable various tools, platforms & other components via the Android SDK Manager.
You can follow the following instructions from android.com [here](http://developer.android.com/sdk/installing/adding-packages.html).

* If you want to use the Eclipse (classic) IDE be sure the apply the linux-dev-env::eclipse recipe against your node.

* If you're using the Eclipse you can following the instructions from android.com [here](http://developer.android.com/sdk/installing/installing-adt.html)
to install the Android Development Tools (ADT) Eclipse plugin.

* You may now want to follow 'Next Steps' from android.com found [here](http://developer.android.com/sdk/installing/next.html).

If you made it this far congratulations! You should now be ready to develope applications for Android.

Lua Development
===============

Apply the recipe linux-dev-env::lua to install the Lua programming language.

Here's a sample role to install Lua and other supported Lua packages:
<pre><code>
name "android_dev"
description "Configure a GNU/Linux desktop/laptop for Android development "
run_list "recipe[linux-dev-env::android]"
override_attributes "linux-dev-env" => { "android_user" => "skywalker",
         	    "android_group" => "skywalker", "install_webkit" => "yes",
		    "install_luarocks" => "yes", "install_luasocket" => "yes" }
</pre></code>

Attributes
==========

The following attribues can be set in this cookbook:

Set Android SDK install directory.
<pre><code>
default['linux-dev-env']['android_sdk_install_dir'] = '/opt'
</pre></code>
Set Android user. CHANGE THIS!
<pre><code>
default['linux-dev-env']['android_user'] = 'skywalker'
</pre></code>
Set Android group, CHANGE THIS!
<pre><code>
default['linux-dev-env']['android_group'] = 'skywalker'
</pre></code>
Set Android SDK version.
<pre><code>
default['linux-dev-env']['android_sdk_version'] = 'r20.0.3'
</pre></code>
Set Eclipse IDE  install directory.
<pre><code>
default['linux-dev-env']['eclipse_ide_install_dir'] = '/opt'
</pre></code>
Set Eclipse IDE version.
<pre><code>
default['linux-dev-env']['eclipse_ide_version'] = '4.2.1'
</pre></code>
Java version to install.
<pre><code>
default['linux-dev-env']['java_version'] = '6u37'
</pre></code>
Set Lua version to install
Possible values: 5.1, 5.2
<pre><code>
default['linux-dev-env']['lua_version'] = '5.2'
</pre></code>
Set to yes to install luakit
<pre><code>
default['linux-dev-env']['install_luakit'] = 'no'
</pre></code>
Set to yes to install luarocks
<pre><code>
default['linux-dev-env']['install_luarocks'] = 'no'
</pre></code>
Set to yes to install luasocket
<pre><code>
default['linux-dev-env']['install_luasocket'] = 'no'
</pre></code>

You will need to at least set 'android_user' and 'android_group'.  This is the uid/gid under which you will be
doing Android development.
