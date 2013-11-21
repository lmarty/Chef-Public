# SQL Server Compact Edition 4.0 SP1 Cookbook

Microsoft SQL Server Compact 4.0 is a free, embedded database that software developers can use for building ASP.NET websites and Windows desktop applications. SQL Server Compact 4.0 has a small footprint and supports private deployment of its binaries within the application folder, easy application development in Visual Studio and WebMatrix, and seamless migration of schema and data to SQL Server.

You can manually download it here: http://www.microsoft.com/en-us/download/details.aspx?id=30709, and use of this cookbook subjects you to any license or redistribution requirements specified at this location.

# Requirements

### Platform

* Windows 2008 R2
* Windows 2012 (Not Tested)

### Cookbooks

* windows 

# Usage

* Add `recipe[sqlce::default]` to your run list.

# Attributes

* `default['sqlce']['4.0']['url']` (Default: `http://download.microsoft.com/download/F/F/D/FFDF76E3-9E55-41DA-A750-1798B971936C/ENU/SSCERuntime_x64-ENU.exe`)
* `default['sqlce']['4.0']['checksum']` (Default: `29e5ff4b478cd6709ac2a0d4a5e065ccec14e5b7b972b6afc852b498c03c40d0`)
* `default['sqlce']['4.0']['package_name']` (Default: `Microsoft SQL Server Compact 4.0 SP1 x64 ENU`)

# Recipes

* default

# Author

Author:: Joe Fitzgerald (<joe.fitzgerald@emc.com>)
