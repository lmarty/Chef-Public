Description
===========

Downloads Sysinternals Bginfo (latest version by default), unzips it
and installs it on the remote machine.  The cookbook will also allow
configuration of the BgInfo data as well as set a default wallpaper
image for BgInfo data to be displayed.

Requirements
============

Requires the OpsCode Windows Cookbook located here: http://community.opscode.com/cookbooks/windows

Attributes
==========

The download location of the Microsoft Technet Sysinternals BgInfo.zip file (case matters):
"sysinternals_download_url"

The directory where BgInfo will be installed.
"bginfo_installation_directory"

Files
=====

config.bgi is the configuration file you want to use with the BgInfo deployment.
background.jpg is the wallpaper you want to use as the default background.

Usage
=====

Download the tarball or use knife to add to add it to your current
configuration.  Change any attributes deemed necessary, upload and 
execute it.  
