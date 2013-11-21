Description
===========

Download and install the [:version] of Magic Disc from their site to mount iso files to your windows machine.  Magic Disc is freeware.  I have recently ensured that the binary "miso.exe" is downloaded as well to enable commandline functionality.

http://www.magiciso.com/tutorials/miso-magicdisc-history.htm

http://searchwindowsserver.techtarget.com/tip/How-to-install-and-manage-virtual-CD-DVDs

Requirements
============

[:platform] == "windows"  NOTE: something in chef 0.10.10 has broken this cookbook with Windows 2008 Datacenter Edition.  Backing Chef down to 0.10.6 or using the new opscode windows installer seems to solve the issue.  Strange.


Attributes
==========

Most of the attributes simply refer to the version of Magic Disc.

Usage
=====

Command line usage:

miso.exe NULL -sdrv 0
Disable all virtual Drives.

miso.exe NULL -vlist
List all of the present virtual CD/DVD driver

miso.exe NULL -mnt f: e:\en_sql_server_2008_r2_standard_x86_x64_ia64_dvd_521546.iso
Mount the MSSQL iso located inside the root of the e:\ drive to virtual drive f:

miso NULL -umnt f:
Unmount virtual drive f:
