# The download location of the Microsoft Technet Sysinternals BgInfo.zip file (case matters).
default['SysinternalsBginfo']['sysinternals_download_url']       = 'http://download.sysinternals.com/files/BGInfo.zip'

# The directory where BgInfo will be installed.
default['SysinternalsBginfo']['bginfo_installation_directory']      = "#{ENV['SYSTEMDRIVE']}\\bginfo"
