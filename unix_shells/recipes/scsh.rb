#
# Cookbook Name:: unix_shells
# Recipe:: scsh 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install A `scheme' interpreter shell designed for writing system programs on Debian & derivatives.
case node['platform_family']
  
    when "debian"
      if node['target_cpu'] == 'x86'
      %w{  scsh scsh-doc }.each do |pkg|
      package pkg
      end
    end

end
