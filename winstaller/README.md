Description
===========

Released Versions of Windows Installer
http://msdn.microsoft.com/en-us/library/windows/desktop/aa371185(v=vs.85).aspx

Windows Installer 4.5	 4.5.6002.18005	Released with Windows Vista with Service Pack 2 (SP2) and Windows Server 2008 with Service Pack (SP2.)
Windows Installer 4.5	 4.5.6001.22162	 Released as a redistributable for Windows Server 2008 and Windows Vista with SP1.
Windows Installer 4.5	 4.5.6001.22159	 Released as a redistributable for Windows XP with Service Pack 2 (SP2) and later, and Windows Server 2003 with SP1 and later.

Requirements
============

Powershell, unfortunately.  Community cookbook "powershell" will satisfy that dependency.  Winstaller version >= 0.0.4 has been tested with Windows 2003 i386, 2008 i386, and 2008 R2 x86_64.  No Itanium systems to test with.

Attributes
==========

Windows Installer Redistributables Download locations:
http://www.microsoft.com/en-us/download/details.aspx?id=8483

Windows6.0-KB942288-v2-ia64.msu	3.4 MB	
http://download.microsoft.com/download/2/6/1/261fca42-22c0-4f91-9451-0e0f2e08356d/Windows6.0-KB942288-v2-ia64.msu

Windows6.0-KB942288-v2-x64.msu	2.9 MB	
http://download.microsoft.com/download/2/6/1/261fca42-22c0-4f91-9451-0e0f2e08356d/Windows6.0-KB942288-v2-x64.msu

Windows6.0-KB942288-v2-x86.msu	1.7 MB	
http://download.microsoft.com/download/2/6/1/261fca42-22c0-4f91-9451-0e0f2e08356d/Windows6.0-KB942288-v2-x86.msu



WindowsServer2003-KB942288-v4-ia64.exe	24.6 MB	
http://download.microsoft.com/download/2/6/1/261fca42-22c0-4f91-9451-0e0f2e08356d/WindowsServer2003-KB942288-v4-ia64.exe

WindowsServer2003-KB942288-v4-x64.exe	4.5 MB	
http://download.microsoft.com/download/2/6/1/261fca42-22c0-4f91-9451-0e0f2e08356d/WindowsServer2003-KB942288-v4-x64.exe

WindowsServer2003-KB942288-v4-x86.exe	2.9 MB	
http://download.microsoft.com/download/2/6/1/261fca42-22c0-4f91-9451-0e0f2e08356d/WindowsServer2003-KB942288-v4-x86.exe



WindowsXP-KB942288-v3-x86.exe	3.2 MB	
http://download.microsoft.com/download/2/6/1/261fca42-22c0-4f91-9451-0e0f2e08356d/WindowsXP-KB942288-v3-x86.exe
(unsupported by this cookbook, sorry, only server OS need apply)

Usage
=====

There is really very little to do: if you need the Windows Installer v4.5, winstaller will ensure that it is installed.

Does not currently work with Windows 2008 R2 x86_64 OS, which comes with Windows Installer v5 pre-installed.

Windows Installer Redistributables MSDN documentation:
http://msdn.microsoft.com/en-us/library/aa372856(v=vs.85)

The Windows Installer 4.5 resdistributable is provided for Windows Vista and Windows Server 2008 operating systems as a .msu file and should be installed using the Windows Update Stand-alone Installer (Wusa.exe.)

The Windows Installer 4.5 on Windows XP and Windows Server 2003 redistributables can be installed using the following command line syntax and options: <Name of the Redistributable> /quiet /norestart

The /norestart command-line option prevents wusa.exe from restarting the computer. However, if a file being updated by the MSU package is in use, then the package is not applied to the computer until the user restarts the computer. This means that applications that use the Windows Installer 4.5 redistributable for Windows Vista and Windows Server 2008 cannot use the Windows Installer 4.5 functionality until the computer is restarted.

It is recommended that the Windows Installer service be stopped when using the update package. When the package is run in full UI mode it detects if the Windows Installer service is running and requests the user to stop the service. If the user continues without stopping the service, the update replaces Windows Installer.

Description of the Windows Update Stand-alone Installer (Wusa.exe) and of.msu files in Windows Vista, Windows 7, Windows Server 2008 and in Windows Server 2008 R2 found here, http://support.microsoft.com/kb/934307

Determining the Windows Installer Version
http://msdn.microsoft.com/en-us/library/windows/desktop/aa368280(v=vs.85).aspx