action :build do

  dna_json = ::File.join(node[:pkg_build][:isolate_solo_dir], "#{rand(99999999)}-solo-dna.json")

  directory ::File.dirname(dna_json) do
    recursive true
  end
  
  file dna_json do
    mode 0644
    content JSON.pretty_generate(
      Mixin::DeepMerge.merge({
          :pkg_build => {
            :pkg_prefix => node[:pkg_build][:pkg_prefix],
            :reprepro => false,
            :isolate => false,
            :replace_deprecated => node[:pkg_build][:replace_deprecated],
            :vendor => node[:pkg_build][:vendor],
            :maintainer => node[:pkg_build][:maintainer]
          },
          :fpm_tng => {
            :vendor => node[:pkg_build][:vendor],
            :maintainer => node[:pkg_build][:maintainer]
          },
          :run_list => new_resource.run_list
        }, new_resource.attributes
      )
    )
  end

  lxc_ephemeral "Isolated: #{new_resource.name}" do
    command "chef-solo -j #{dna_json}"
    base_container new_resource.container
    user 'root'
    key '/opt/hw-lxc-config/id_rsa'
    virtual_device 2000
    stream_output true
  end
end
