Description
===========

Install Microsoft Silverlight 3.0

Requirements
============

Platform: Microsoft Windows

Attributes
==========

* `node['silverlight']['url']` - Download silverlight from this url. Default is to download the Windows installer from: http://www.microsoft.com/getsilverlight/Get-Started/Install/Default.aspx.
* `node['silverlight']['checksum']` - Checksum of the silverlight installer.
* `node['silverlight']['options']` - Array of options to pass to the silverlight installer. By default the recipe already uses /q for quiet install. See __Usage__ below for other options that can be specified here.

Usage
=====

Modify the installation options as required. By default, no options are specified. This must be an array. Available options are:

* /q - this is hardcoded in the recipe by default since presumably, you want this.
* /doNotRequireDRMPrompt - turns off the prompt for DRM playback.
* /ignorewarnings - ignore non-fatal warnings during installation.
* /noupdate - disable internal auto-updater.
* /qu - quiet uninstall. You probably don't want to use this, as it doesn't make sense with this cookbook.

For example, to disable the DRM prompt and auto-updates, put this in the role where you have the silverlight installation:

    name "windows_media_center"
    description "Systems that are windows media center playback systems"
    run_list("recipe[silverlight]")
    default_attributes(
      "silverlight" => {
        "options" => ["/doNotRequireDRMPrompt", "/noupdate"]
      }
    )

Note that the preceeding slashes are required.

Thanks to [this blog post](http://www.ervik.as/index.php/thegidwimguide-mainmenu/1935-unattended-install-of-microsoft-silverlight) for documenting the installer options. I'm sure they're in the Silverlight deployment guide, but TL;DR.

License and Author
==================

silverlight::default recipe inspired by Doug MacEachern's <dougm@vmware.com> "windows::dotnetfx" recipe.

Author:: Joshua Timberman

Copyright:: 2011, Joshua Timberman <cookbooks@housepub.org>
Copyright:: 2010, VMware, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
