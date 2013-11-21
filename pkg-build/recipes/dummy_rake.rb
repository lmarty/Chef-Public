Chef::Log.warn 'Building dummy rake package with no contents for dependency resolution only.'

rake_name = [node[:pkg_build][:pkg_prefix], 'rubygem', 'rake'].compact.join('-')

builder_dir rake_name do
end

reprepro_deb rake_name do
  action :remove
end

fpm_tng_package rake_name do
  output_type 'deb'
  version '99.9.9'
  description 'Empty rake installation to prevent conflicts with ruby provided rake'
  chdir File.join(node[:builder][:packaging_dir], rake_name)
  reprepro node[:pkg_build][:reprepro]
end
