define :build_passenger, :version => nil, :ruby_version => nil, :repository => nil, :ruby_dependency => nil do

  include_recipe 'pkg-build::deps'

  ruby_block 'Detect omnibus ruby' do
    block do
      if(node[:languages][:ruby][:ruby_bin].include?('/opt/chef'))
        raise 'Cannot build passenger against omnibus Chef Ruby installation!'
      end
    end
    not_if do
      node[:pkg_build][:passenger][:allow_omnibus_chef_ruby]
    end
  end

  if(node[:pkg_build][:use_pkg_build_ruby] && params[:ruby_dependency].to_s == 'pkg_build_ruby')
    params[:ruby_dependency] = PkgBuild::Ruby.ruby_name(node, params[:ruby_version])
  end

  # TODO: Move these out to attributes
  %w(libcurl4-gnutls-dev apache2 apache2-prefork-dev).each do |dep_pkg|
    package dep_pkg
  end

  # define names and prefixes as required
  libpassenger_name = PkgBuild::Ruby.gem_name(node, 'libapache2-mod-passenger', params[:ruby_version])
  passenger_gem_name = PkgBuild::Ruby.gem_name(node, 'passenger', params[:ruby_version])
  gem_prefix = node[:pkg_build][:gems][:dir] || node[:languages][:ruby][:gems_dir]
  pass_prefix = "gems/passenger-#{params[:version]}"

  gem_version = Gem::Version.new(params[:version])
  
  if(gem_version.segments.first < 4)
    apache_mod_path = 'ext/apache2/mod_passenger.so'
  elsif(gem_version.segments.first == 4 && gem_version.segments[2] < 10)
    apache_mod_path = 'libout/apache2/mod_passenger.so'
  else
    apache_mod_path = 'buildout/apache2/mod_passenger.so'
  end

  builder_dir "passenger-#{params[:version]}" do
    init_command "#{node[:pkg_build][:gems][:exec]} install --install-dir . --no-ri --no-rdoc --ignore-dependencies -E --version #{params[:version]} passenger"
    suffix_cwd pass_prefix
    commands [
      "#{node[:pkg_build][:rake_bin]} apache2",
      'mkdir -p $PKG_DIR/libmod/etc/apache2/mods-available',
      "mkdir -p $PKG_DIR/libmod/#{node[:pkg_build][:passenger][:root]}/apache2/modules",
      "mkdir -p $PKG_DIR/libmod/#{node[:pkg_build][:passenger][:root]}/phusion-passenger",
      "cp #{apache_mod_path} $PKG_DIR/libmod/#{node[:pkg_build][:passenger][:root]}/apache2/modules",
      "echo \"<IfModule mod_passenger.c>\\n  PassengerRoot #{node[:pkg_build][:gems][:dir]}/#{pass_prefix}\n  PassengerRuby #{node[:pkg_build][:ruby_bin]}\\n</IfModule>\\n\" > $PKG_DIR/libmod/etc/apache2/mods-available/passenger.conf",
      "echo \"LoadModule passenger_module #{node[:pkg_build][:passenger][:root]}/apache2/modules/mod_passenger.so\" > $PKG_DIR/libmod/etc/apache2/mods-available/passenger.load",
      "mkdir -p $PKG_DIR/gem/#{node[:pkg_build][:gems][:dir]}",
      "cp -a ../../gems $PKG_DIR/gem/#{node[:pkg_build][:gems][:dir]}",
      "cp -a ../../specifications $PKG_DIR/gem/#{node[:pkg_build][:gems][:dir]}",
      "cp -a ../../bin $PKG_DIR/gem/#{node[:pkg_build][:ruby_bin_dir]}",
    ]
  end

  conflict_versions = []
  if(params[:multi_rubies])
    conflict_versions = params[:multi_rubies].map do |version|
      unless(version == params[:ruby_version])
        [node[:pkg_build][:pkg_prefix], 'rubygem', version].compact.join('-')
      end
    end.compact
  end
  if(node[:pkg_build][:replace_deprecated])
    gem_conflicts = conflict_versions + [[node[:pkg_build][:pkg_prefix], 'rubygem'].compact.join('-')]
    lib_conflicts = conflict_versions + [node[:pkg_build][:pkg_prefix]]
  else
    gem_conflicts = lib_conflicts = conflict_versions
  end


  deps_resource = fpm_tng_gemdeps 'passenger' do
    gem_fix_name false
    gem_package_name_prefix [node[:pkg_build][:pkg_prefix], 'rubygem', params[:ruby_version]].compact.join('-')
#    package_name_suffix params[:ruby_version] if params[:ruby_version] Enable this when FPM release fixed version
    gem_gem node[:pkg_build][:gems][:exec]
    auto_depends false
    reprepro node[:pkg_build][:reprepro]
    repository params[:repository] if params[:repository]
    version params[:version]
  end

  fpm_tng_package libpassenger_name do
    output_type 'deb'
    version params[:version]
    description 'Passenger apache module installation'
    chdir File.join(node[:builder][:packaging_dir], "passenger-#{params[:version]}", 'libmod')
    depends [
      'apache2', 'apache2-mpm-prefork', passenger_gem_name, node[:pkg_build][:passenger][:ruby_dependency]
    ].compact
    conflicts lib_conflicts.map{|v| "#{v}-libapache2-mod-passenger"}
    reprepro node[:pkg_build][:reprepro]
    repository params[:repository] if params[:repository]
  end

  fpm_tng_package passenger_gem_name do
    output_type 'deb'
    version params[:version]
    description 'Passenger apache module installation'
    chdir File.join(node[:builder][:packaging_dir], "passenger-#{params[:version]}", 'gem')
    depends lazy{ deps_resource.generated_dependencies }
    conflicts gem_conflicts.map{|v| "#{v}-passenger"}
    reprepro node[:pkg_build][:reprepro]
    repository params[:repository] if params[:repository]
  end
end
