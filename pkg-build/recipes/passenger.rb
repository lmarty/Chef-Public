versions = [node[:pkg_build][:passenger][:version]]
versions += node[:pkg_build][:passenger][:versions] if node[:pkg_build][:passenger][:versions]
versions.uniq!

if(node[:pkg_build][:isolate])
  node[:pkg_build][:passenger][:ruby_versions].each do |r_ver, pass_vers|
    Array(pass_vers).each do |passenger_version|
      pkg_build_isolate "passenger-rb#{r_ver}" do
        container "ubuntu_1204-ruby#{r_ver}"
        attributes(
          :pkg_build => {
            :passenger => {
              :version => passenger_version,
              :ruby_version => r_ver,
              :ruby_dependency => PkgBuild::Ruby.ruby_name(node, r_ver)
            }
          },
          :builder => {
            :build_dir => File.join(node[:builder][:build_dir], "ruby_#{r_ver}"),
            :packaging_dir => File.join(node[:builder][:packaging_dir], "ruby_#{r_ver}")
          }
        )
        run_list %w(recipe[pkg-build::passenger])
        not_if do
          File.exists?(File.join(node[:fpm_tng][:package_dir], "#{PkgBuild::Ruby.gem_name(node, 'libapache2-mod-passenger', r_ver)}-#{passenger_version}.deb")) &&
            File.exists?(File.join(node[:fpm_tng][:package_dir], "#{PkgBuild::Ruby.gem_name(node, 'passenger', r_ver)}-#{passenger_version}.deb"))
        end
      end
    end
  end
else
  include_recipe 'pkg-build::deps'
  [node[:pkg_build][:passenger][:versions] + Array(node[:pkg_build][:passenger][:version])].flatten.compact.uniq.each do |passenger_version|
    build_passenger "passenger-#{passenger_version}" do
      version passenger_version
      ruby_version node[:pkg_build][:passenger][:ruby_version]
      ruby_dependency node[:pkg_build][:passenger][:ruby_dependency]
      repository node[:pkg_build][:repository]
    end
  end
end
