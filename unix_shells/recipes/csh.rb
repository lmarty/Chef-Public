#
# Cookbook Name:: unix_shells
# Recipe:: csh 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install CSH, A shell with C-like syntax on Debian & derivatives.
case node['platform_family']
  
  when "debian"
    %w{ csh }.each do |pkg|
    package pkg
  end

end
