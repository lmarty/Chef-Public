if(node[:pkg_build][:repository])
  pkg_build_repository node[:pkg_build][:repository] do
    package_store node[:fpm_tng][:package_dir]
  end
end
