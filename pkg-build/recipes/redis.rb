if(node[:pkg_build][:isolate])
  include_recipe 'pkg-build'
  [node[:pkg_build][:redis][:version], node[:pkg_build][:redis][:versions]].flatten.compact.uniq.each do |ver|
    pkg_build_isolate "redis-#{ver}" do
      container 'ubuntu_1204'
      attributes(
        :pkg_build => {
          :redis => {
            :version => ver,
            :user => node[:pkg_build][:redis][:user],
            :group => node[:pkg_build][:redis][:group]
          }
        }
      )
      run_list %w(recipe[pkg-build::redis])
      not_if do
        File.exists?(
          File.join(
            node[:fpm_tng][:package_dir],
            "#{[node[:pkg_build][:pkg_prefix], 'redis-server', ver].compact.join('-')}.deb"
          )
        )
      end
    end
  end
else
  include_recipe 'pkg-build::deps'
  [node[:pkg_build][:redis][:version], node[:pkg_build][:redis][:versions]].flatten.uniq.each do |ver|
    build_redis ver do
      version ver
      if(node[:pkg_build][:repository])
        repository node[:pkg_build][:repository]
      end
    end
  end
end
