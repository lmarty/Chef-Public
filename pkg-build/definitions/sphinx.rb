define :build_sphinx, :version => nil, :repository => nil, :reprepro => nil do

  include_recipe 'pkg-build::deps'

  node[:pkg_build][:sphinx][:build_dependencies].each do |d_pkg|
    package d_pkg
  end

  sphinx_name = "sphinx-#{params[:version]}"

  builder_remote sphinx_name do
    remote_file "http://sphinxsearch.com/files/sphinx-#{params[:version]}-release.tar.gz"
    suffix_cwd "#{sphinx_name}-release"
    commands [
      './configure --prefix=$PKG_DIR/usr/local',
      'make',
      'make install'
    ]
    creates File.join(node[:builder][:packaging_dir], sphinx_name, 'usr/local/bin/searchd')
  end

  fpm_tng_package [node[:pkg_build][:pkg_prefix], 'sphinxsearch'].compact.join('-') do
    output_type 'deb'
    description 'Sphinx search'
    depends %w(libc6 libexpat1 libgcc1 libmysqlclient18 libpq5 libstdc++6 libstemmer0d zlib1g)
    version params[:version]
    chdir File.join(node[:builder][:packaging_dir], sphinx_name)
    reprepro params[:reprepro]
    repository params[:repository] if params[:repository]
  end
end
