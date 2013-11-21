#
# Cookbook Name:: repos
# Recipe:: emacs-snapshot
#

case node['platform']
when "debian"
  apt_repository "emacs-snapshot" do
    uri "http://emacs.naquadah.org/"
    distribution "unstable/"
    key "http://emacs.naquadah.org/key.gpg"
    deb_src false
  end
end
