Description
===========

Windows Azure control panel:
https://manage.windowsazure.com/

FAQ (SQL Data Sync):
http://msdn.microsoft.com/en-us/library/windowsazure/hh667301.aspx

Sync Team Blog:
http://blogs.msdn.com/b/sync/

This cookbook will install dotnet4fx and/or dotnet45fx, along with the pre-requisites to the Windows Azure software for MSSQL.


Requirements
============

Using MSSQL Azure with a hosted MSSQL database: First, ENSURE your workstation's silverlight install is up to date... Otherwise, you will not be able to use the Azure admin web control panel.

Prerequisites to installing the sync agent: dotnet4fx, windows installer 4.5 and then two SQL packages (clrtypes and shared management objects).  The dependency on my winstaller cookbook provides the requisite windows installer version.  Charon should successfully install the latest version of all the pre-requisites.  Note, documentation of Data Sync prior to the October 2012 Preview was confusing when it came to which specific version of SQL pre-requisites to install, however, this has been clarified in recent documentation.

As of now, The Data Sync Agent does NOT have an unattended/silent install... So Charon simply installs the prerequisites and the datasync bits and then quits.  Please be aware, that as this is pre-release software (and it shows!), there are a few minor "gotchas," even while installing manually.  During the manual install, ensure that you use a fully-qualified account name (neither "user" nor ".\user" works properly... only "hostname\user" is correct).  The user will need "logon as a service" permissions as well.

Frequently Encountered Problems:
http://msdn.microsoft.com/en-us/library/windowsazure/hh667321.aspx#bkmk_notsufficientprivileges

Install sync agent 
http://msdn.microsoft.com/en-us/library/hh667304.aspx#bkmk_installagent
http://msdn.microsoft.com/en-us/library/windowsazure/hh667308


Prerequisites

Prior to Configuring a Sync Group

1.Provisioned a SQL Data Sync server – Provision an Azure Sync Server.
http://msdn.microsoft.com/en-us/library/hh667324.aspx

- If there is no SQL Database server you need to create one.
- enable access to the hosting SQL Database by SQL Data Sync by setting the source hosted server's firewall rules (maybe not necessary?).
- enable access to the azure SQL Database by SQL Data Sync by setting the azure server's firewall rules.
 On the firewall rules page check the Allow other Windows Azure services to access this server checkbox is checked. (Figure 2.1)
- Note!  the new Azure portal that was released in Oct/Nov 2012 does NOT contain the "Data Sync Server" UI!  Craaaazy, I know. See this article for details (basically, you need to switch back to the old portal to find the proper UI):
http://blogs.msdn.com/b/sync/archive/2012/10/28/where-in-the-world-is-sql-data-sync.aspx

2.Created and name the sync group – Name a Sync Group.
http://msdn.microsoft.com/en-us/library/windowsazure/hh667311.aspx


3.Added a SQL Database hub database to the sync group –Add a Windows Azure SQL Database as the Hub. 


4.Added one or more other databases to the sync group.


Add SQL Database instances – Add a Windows Azure SQL Database as a Member.
Add SQL Server databases – Add a SQL Server Member Database.



Attributes
==========

The very few attributes inside this cookbook serve mostly to point at installation media.

Usage
=====

Add the charon::default recipe to your run list, and it will install dotnet4fx, the datasync pre-requisites, and then download the datasync bits.  As of the initial version of this cookbook, no unattended installation of the datasync software was possible... So the cookbook quits at that point.  This cookbook can also install dotnet45fx if desired (for standalone dotnet45fx installation, just add charon::dotnet45fx to the run list).