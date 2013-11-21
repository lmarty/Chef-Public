include_recipe 'build-essential'

if(node[:pkg_build][:repmgr][:pg_bin_dir])
  pg_bindir = node[:pkg_build][:repmgr][:pg_bin_dir]
else
  # We want pg_config binary available at compile time
  p = package 'libpq-dev' do
    action :nothing
  end
  p.run_action(:install)

  pg_bindir = %x{pg_config --bindir}.strip
end

(node[:pkg_build][:repmgr][:packages][:dependencies] + Array(node[:pkg_build][:repmgr][:packages][:pg_dev])).each do |pkg|
  package pkg
end

r_url = File.join(node[:pkg_build][:repmgr][:base_uri], "repmgr-#{node[:pkg_build][:repmgr][:version]}.tar.gz")
repmgr_postinst = File.join(node[:builder][:build_dir], "repmgr-#{node[:pkg_build][:repmgr][:version]}", 'postinst')

builder_remote "repmgr-#{node[:pkg_build][:repmgr][:version]}" do
  remote_file r_url
  suffix_cwd "repmgr-#{node[:pkg_build][:repmgr][:version]}"
  commands ["make USE_PGXS=1 install DESTDIR=$PKG_DIR"]
end

template repmgr_postinst do
  source 'repmgr-postinst.erb'
  mode 0755
  variables(
    :pg_bindir => pg_bindir
  )
end

fpm_tng_package [node[:pkg_build][:prefix], 'repmgr'].compact.join('-') do
  output_type 'deb'
  description "PostgreSQL Replication Manager"
  version node[:pkg_build][:repmgr][:version]
  chdir File.join(node[:builder][:packaging_dir], "repmgr-#{node[:pkg_build][:repmgr][:version]}")
  after_install repmgr_postinst
  depends %w(libpq-dev)
  reprepro node[:pkg_build][:reprepro]
end

