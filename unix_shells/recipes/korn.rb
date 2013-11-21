#
# Cookbook Name:: unix_shells
# Recipe:: korn 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install KORN: A shell Written by David Korn, while at Bell Labs on Debian & derivatives.
case node['platform_family']
  
  when "debian"
    %w{ ksh }.each do |pkg|
    package pkg
  end
 
  if node.set['unix_shells']['install_pdksh'] = 'yes'    
    # Install Public domain version of the Korn shell
    %w{ pdksh }.each do |pkg|
    package pkg
    end
  end

  if node.set['unix_shells']['install_mksh'] = 'yes'
    # Install the MirBSD Korn Shell
    %w{ mksh }.each do |pkg|
    package pkg
    end
  end

end
