#
# Cookbook Name:: unix_shells
# Recipe:: zsh 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install ZSH: A relatively modern shell that is backward compatible with bash.
case node['platform_family']
  
  when "debian"
    %w{ zsh zsh-doc zsh-dev zsh-lovers zshdb  }.each do |pkg|
    package pkg
  end

  when "redhat"
    %w{ zsh zsh-html }.each do |pkg|
    package pkg
  end

end
