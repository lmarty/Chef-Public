define :build_ruby, :version => nil, :patchlevel => nil, :repository => nil do

  r_version = params[:version]
  r_patchlevel = params[:patchlevel]
  r_fullversion = [params[:version], params[:patchlevel]].join('-')

  include_recipe 'pkg-build::deps'

  node[:pkg_build][:ruby][:package_dependencies].each do |r_dep|
    package r_dep
  end

  ruby_name = PkgBuild::Ruby.ruby_name(node, r_version)
  ruby_build = PkgBuild::Ruby.ruby_build(node, r_version, r_patchlevel)

  builder_remote ruby_build do
    remote_file ::File.join(node[:pkg_build][:ruby][:uri_base], r_version[0,3], "ruby-#{r_fullversion}.tar.gz")
    suffix_cwd "ruby-#{r_fullversion}"
    commands [
      'autoconf',
      "./configure --prefix=#{File.join(node[:pkg_build][:ruby][:install_prefix], "ruby-#{params[:version]}")} --bindir=#{File.join(node[:pkg_build][:ruby][:install_prefix], 'bin')} --disable-install-doc --enable-shared --with-baseruby=#{RbConfig.ruby} --program-suffix=#{r_version}",
      "make",
      "make install DESTDIR=$PKG_DIR"
    ]
    creates File.join(node[:fpm_tng][:package_dir], "#{ruby_build}.deb")
  end

  template File.join(node[:builder][:build_dir], ruby_build, 'postinst') do
    source 'ruby-postinst.erb'
    variables(
      :version => params[:version],
      :priority => params[:version].split('.').map(&:to_i).inject(:+)
    )
    mode 0755
  end

  fpm_tng_package ruby_build do
    package_name ruby_name
    package File.join(node[:fpm_tng][:package_dir], "#{ruby_build}.deb")
    output_type 'deb'
    description "Ruby language - #{r_fullversion}"
    version r_fullversion
    chdir File.join(node[:builder][:packaging_dir], ruby_build)
    after_install File.join(node[:builder][:build_dir], ruby_build, 'postinst')
    depends %w(
      ca-certificates libc6 libffi6 libgdbm3 libncursesw5 libreadline6 libssl1.0.0 
      libtinfo5 libyaml-0-2 zlib1g
    )
    # provides - rake gem
    conflicts [node[:pkg_build][:pkg_prefix], 'ruby'].compact.join('-') if node[:pkg_build][:replace_deprecated]
    reprepro node[:pkg_build][:reprepro]
    repository params[:repository] if params[:repository]
  end

end
