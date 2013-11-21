#
# Cookbook Name:: amazon_s3cmd
# Recipe:: source
#
# Copyright 2013, Gerald L. Hevener Jr., M.S.
#

# Install required packages.
case node['platform_family']
  when 'rhel'
    if node['platform_version'].to_i > 6
      %w{ git python-setuptools }.each do |pkg|
        package pkg do
          action :install
        end
      end
    end
    if node['platform_version'].to_i < 6
      # Get git from EPEL.
      include_recipe 'yum::epel'
      %w{ git python-setuptools }.each do |pkg|
        package pkg do
          action :install
        end
      end
    end
#  end
  when 'debian'
  %w{ git-core python-setuptools }.each do |pkg|
    package pkg do
      action :install
    end
  end
  when 'suse'
  %w{ git-core python-setuptools }.each do |pkg|
    package pkg do
      action :install
    end
  end
# Fails on python setup.py install.
#  when 'gentoo'
#  %w{ git setuptools }.each do |pkg|
#    package pkg do
#      action :install
#    end
#  end
end

# Create install directory.
directory "#{node['amazon_s3cmd']['install_prefix_root']}/share/s3cmd" do
  action :create
  recursive true
end

# Clone s3cmd fro github.
git "#{node['amazon_s3cmd']['install_prefix_root']}/share/s3cmd" do
  repository "git://github.com/s3tools/s3cmd.git"
  reference node['amazon_s3cmd']['version']
  action :sync
end

# Build s3cmd.
execute "build_s3cmd" do
  user node['amazon_s3cmd']['install_user']
  cwd "#{node['amazon_s3cmd']['install_prefix_root']}/share/s3cmd"
  command "python setup.py install"
  action :run
  not_if "test -f #{node['amazon_s3cmd']['install_prefix_root']}/share/s3cmd"
end

# Link the binary to the one we built.
link "#{node['amazon_s3cmd']['install_prefix_root']}/bin/s3cmd" do
  to "#{node['amazon_s3cmd']['install_prefix_root']}/share/s3cmd/s3cmd"
  action :create
end

# Deploy s3cfg and populate S3 creds via encrypted data bag.
include_recipe 'amazon_s3cmd::databag_and_config'
