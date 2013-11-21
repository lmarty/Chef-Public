default[:pkg_build][:passenger][:root] = File.dirname(node[:languages][:ruby][:bin_dir].to_s)
default[:pkg_build][:passenger][:version] = ''
default[:pkg_build][:passenger][:versions] = []
default[:pkg_build][:passenger][:ruby_dependency] = nil
default[:pkg_build][:passenger][:allow_omnibus_chef_ruby] = false
default[:pkg_build][:passenger][:ruby_versions] = {} # {'1.9.3' =>
# [versions], '2.0.0' => [versions]
