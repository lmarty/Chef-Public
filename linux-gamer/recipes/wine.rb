#
# Cookbook Name:: linux-gamer
# Recipe:: wine 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Load Apt cookbook
include_recipe "apt"

# Install latest version of WINE via
# WineHQ's PPA for Ubuntu, Kubuntu, & Xubuntu.
case node["platform"]
  when "ubuntu","kubuntu","xubuntu"
    apt_repository "wine-repo" do
    uri "http://ppa.launchpad.net/ubuntu-wine/ppa/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "hkp://keyserver.ubuntu.com"
    key "F9CB8DB0"
    deb_src "true"
    Chef::Log.info("Wine PPA: #{uri} #{distribution} #{components}")
    action :add
    not_if "test -e /etc/apt/sources.list.d/wine-repo-source.list"
  end
end
