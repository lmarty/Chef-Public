#
# Cookbook Name:: unix_shells
# Recipe:: bash 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install the GNU Bourne Again SHell.
case node['platform_family']
  
  when "debian"
    %w{ bash bash-completion bash-doc }.each do |pkg|
    package pkg
  end

  when "redhat"
    %w{ bash bash-doc }.each do |pkg|
    package pkg
  end

end
