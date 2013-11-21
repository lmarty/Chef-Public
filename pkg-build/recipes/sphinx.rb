if(node[:pkg_build][:isolate])

  include_recipe 'pkg-build'
  
  [node[:pkg_build][:sphinx][:version], node[:pkg_build][:sphinx][:versions]].flatten.compact.uniq.each do |ver|
    pkg_build_isolate "sphinx-#{ver}" do
      container 'ubuntu_1204'
      attributes(
        :pkg_build => {
          :sphinx => {
            :version => ver,
            :build_dependencies => node[:pkg_build][:sphinx][:build_dependencies]
          }
        }
      )
      run_list %w(recipe[pkg-build::sphinx])
      not_if do
        File.exists?(
          File.join(
            node[:fpm_tng][:package_dir],
            "#{[node[:pkg_build][:pkg_prefix], 'sphinx', ver].compact.join('-')}.deb"
          )
        )
      end
    end
  end
else
  [node[:pkg_build][:sphinx][:version], node[:pkg_build][:sphinx][:versions]].flatten.uniq.each do |ver|
    build_sphinx ver do
      version ver
      if(node[:pkg_build][:repository])
        repository node[:pkg_build][:repository]
      end
    end
  end
end
