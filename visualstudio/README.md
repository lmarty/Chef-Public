Description
===========

This cookbook will perform an unattended installation of Microsoft Visual Studio 2012.

Basic Visual Studio 2012 Installation:
http://msdn.microsoft.com/en-us/library/vstudio/e2h7fzkw.aspx

Unattended Visual Studio 2012 Installation:
http://msdn.microsoft.com/en-us/library/vstudio/ee225237.aspx

Visual Studio 2012 Administrators Guide:
http://msdn.microsoft.com/en-us/library/vstudio/ee225238.aspx

Requirements
============

Visual Studio 2012 installation media.  "Charon" cookbook, to install dotnet45 prerequisite (could be bypassed; however, installing dotnet45 prior to visual studio 2012 is recommended because it prevents a reboot).

Attributes
==========

It is intended that all tunable attributes are located inside the default file.  The individual version files simply work off the default attributes, and are not intended to be modified.

Usage
=====

Add the visualstudio::default recipe to your run list, and customize the attributes inside the default file.  The individual version attributes files are not intended to be modified, and the individual version recipes are not intended to be added directly to the run list.