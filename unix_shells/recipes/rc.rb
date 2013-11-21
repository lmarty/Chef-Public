#
# Cookbook Name:: unix_shells
# Recipe:: rc 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install RC: An implementation of the AT&T Plan 9 shell.
case node['platform_family']
  
  when "debian"
    %w{ rc }.each do |pkg|
    package pkg
  end

end
