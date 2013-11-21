include_recipe 'pkg-build::deps'

if(node[:pkg_build][:isolate])
  include_recipe 'lxc'
  include_recipe 'apt::cacher-ng'

  # Force an early restart since template update is delayed
  service 'pkg-build-cacher' do
    service_name 'apt-cacher-ng'
    action :restart
  end
  
  Chef::Log.info 'Building containers for isolated package construction'
  
  directory node[:pkg_build][:isolate_solo_dir] do
    recursive true
  end

  [node[:builder][:build_dir], node[:builder][:packaging_dir]].each do |dir|
    directory dir do
      recursive true
    end
  end

  node[:pkg_build][:isolated_containers].each do |name, opts|
    pkg_coms = [
      'update -y -q',
      'upgrade -y -q',
      'install curl -y -q',
      'install build-essential -y -q'
    ]
    if(!opts[:template].scan(%r{debian|ubuntu}).empty?)
      pkg_man = 'apt-get'
    elsif(!opts[:template].scan(%r{fedora|centos}).empty?)
      pkg_man = 'yum'
    end
    if(pkg_man)
      pkg_coms.map! do |c|
        "#{pkg_man} #{c}"
      end
    else
      pkg_coms = []
    end

    lxc_container name do
      template opts[:template]
      template_opts opts[:template_options]
      Array(Chef::Config[:cookbook_path]).each do |path|
        fstab_mount "cookbooks: #{path}" do
          file_system path
          mount_point ::File.join('/var/chef', ::File.basename(path))
          type 'none'
          options 'bind,ro'
        end
      end
      fstab_mount "Solo json store" do
        file_system node[:pkg_build][:isolate_solo_dir]
        mount_point node[:pkg_build][:isolate_solo_dir]
        type 'none'
        options 'bind,ro'
      end
      fstab_mount "Package directory store" do
        file_system node[:fpm_tng][:package_dir]
        mount_point node[:fpm_tng][:package_dir]
        type 'none'
        options 'bind,rw'
      end
      [node[:builder][:build_dir], node[:builder][:packaging_dir]].each do |dir|
        fstab_mount "Builder directory: #{dir}" do
          file_system dir
          mount_point dir
          type 'none'
          options 'bind,rw'
        end
      end
      initialize_commands [
        'rm -f /etc/sysctl.d/10-console-messages.conf',
        'rm -f /etc/sysctl.d/10-ptrace.conf',
        'rm -f /etc/sysctl.d/10-kernel-hardening.conf'
      ] + pkg_coms + [
        "curl -L https://www.opscode.com/chef/install.sh | bash -s -- -v #{Chef::VERSION}"
      ]
    end
    lxc = ::Lxc.new(name)
    file lxc.rootfs.join('etc/apt/apt.conf.d/01proxy').to_path do
      content "Acquire::http::Proxy \"http://#{node[:lxc][:addr]}:3142\";\nAcquire::https::Proxy \"DIRECT\";\n"
      mode 0644
    end
  end
  
  # Force full cookbook downloads
  CookbookSynchronizer.send(:remove_const, :EAGER_SEGMENTS)
  CookbookSynchronizer.const_set(:EAGER_SEGMENTS, CookbookVersion::COOKBOOK_SEGMENTS)
  Chef::Log.warn 'Performing full cookbook sync...'
  rest = Chef::REST.new(Chef::Config[:chef_server_url], node.name, Chef::Config[:client_key])
  run_list_expansion = node.run_list.expand(node.chef_environment)
  cookbook_hash = rest.post_rest(
    "environments/#{node.chef_environment}/cookbook_versions",
    :run_list => run_list_expansion.recipes.with_version_constraints_strings
  )
  CookbookSynchronizer.new(cookbook_hash, EventDispatch::Dispatcher.new).sync_cookbooks
  Chef::Log.warn 'Full cookbook sync has been completed!'
end
