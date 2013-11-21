# Git Annex
# =========

if node['platform'] == 'mac_os_x'
  include_recipe 'dmg'

  case node['platform_version']
  when /^10\.6\./
    dmg_bz2_url = "https://s3.amazonaws.com/downloads.3ofcoins.net/git-annex/OSX-10.6-Snow_Leopard/git-annex.dmg.bz2"
  when /^10\.7\./
    dmg_bz2_url = "http://downloads.kitenet.net/git-annex/OSX/current/10.7.5_Lion/git-annex.dmg.bz2"
  when /^10\.8\./
    dmg_bz2_url = "http://downloads.kitenet.net/git-annex/OSX/current/10.8.2_Mountain_Lion/git-annex.dmg.bz2"
  else
    raise "OSX #{node['platform_version']} not supported"
  end

  dmg_path = "#{Chef::Config[:file_cache_path]}/git-annex.dmg"

  execute "bunzip2 -c #{dmg_path}.bz2 > #{dmg_path}" do
    action :nothing
    creates dmg_path
  end

  remote_file "#{dmg_path}.bz2" do
    source dmg_bz2_url
    notifies :run, "execute[bunzip2 -c #{dmg_path}.bz2 > #{dmg_path}]", :immediately
  end

  dmg_package 'git-annex' do
    action :install
  end

  %w[git-annex git-annex-shell git-annex-webapp runshell bundle].each do |bin|
    link "/usr/local/bin/#{bin}" do
      to "/Applications/git-annex.app/Contents/MacOS/#{bin}"
    end
  end
else
  include_recipe 'apt'
  apt_repository "git-annex" do
    uri 'http://ppa.launchpad.net/fmarier/git-annex/ubuntu'
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key "90F7E9EB"
    only_if { node['platform'] == 'ubuntu' && node['lsb']['codename'] == 'precise' }
  end
  package 'git-annex'
end
