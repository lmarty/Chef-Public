#
# Cookbook Name:: unix_shells
# Recipe:: tcsh 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install TENEX C Shell, an enhanced version of Berkeley csh.
case node['platform_family']
  
  when "debian"
    %w{ tcsh }.each do |pkg|
    package pkg
  end
  
  when "redhat"
    %w{ tcsh }.each do |pkg|
    package pkg
  end  

end
