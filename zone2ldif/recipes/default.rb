#
# Cookbook Name:: zone2ldif
# Recipe:: default
#
# Copyright 2013, Gerald L. Hevener Jr., M.S.
#
# Install Perl.
include_recipe 'perl'

# Download zone2ldif.pl to /usr/local/bin
remote_file "/usr/local/bin/zone2ldif.pl" do
  source "http://bind9-ldap.bayour.com/zone2ldif.pl"
  mode "0744"
  owner "root"
  group "root"
  checksum "b1f6fed631ba22ebeef390a691cbaf3d"
  not_if "test -f /usr/local/bin/zone2ldif.pl"
end
