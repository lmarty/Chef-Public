#
# Cookbook Name:: amazon_s3cmd
# Recipe:: default
#
# Copyright 2013, Gerald L. Hevener Jr., M.S.
#

# Install Amazon S3 client.
case node['platform_family']
 
  when "debian"
    %w{ python-magic s3cmd }.each do |pkg|
    package pkg
  end

  when "redhat"
    %w{ s3cmd }.each do |pkg|
    package pkg
  end

# No package for suse.
#  when "suse"
#    %w{ s3cmd }.each do |pkg|
#    package pkg
#  end

# mount_virtualbox_shared_folder error.
#  when "bsd"
#    %w{ s3cmd }.each do |pkg|
#    package pkg
#  end

  when "arch"
    %w{ wget curl s3cmd }.each do |pkg|
    package pkg
  end

when "gentoo"
    %w{ s3cmd }.each do |pkg|
    package pkg
  end

end

# Deploy s3cfg and populate S3 creds via encrypted data bag.
include_recipe 'amazon_s3cmd::databag_and_config'
