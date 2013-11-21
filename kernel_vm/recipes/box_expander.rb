
# We use boxes so include virtual box to convert
package 'virtualbox'

node[:kernel_vm][:boxes].each do |remote|
  remote_file "kernel_vm box fetcher[#{File.basename(remote)}]" do
    path File.join(node[:kernel_vm][:image_storage], 'boxes', File.basename(remote))
    action :create_if_missing
    source remote
    mode 0644
    backup false
  end
  ruby_block "kernel_vm box unpacker[#{File.basename(remote)}]" do
    block do
      current_dir = Dir.pwd
      Dir.chdir(File.join(node[:kernel_vm][:image_storage], 'boxes'))
      %x{tar xf #{File.join(node[:kernel_vm][:image_storage], 'boxes', File.basename(remote))}}
      name = File.basename(Dir.glob('*.vmdk').first)
      File.rename(name, File.basename(remote).sub('.box', '.vmdk'))
      Dir.glob('*.ovf').each{|f| File.delete(f) }
      File.delete('Vagrantfile') if File.exists?('Vagrantfile')
      Dir.chdir(current_dir)
    end
    not_if do
      File.exists?(
        File.join(node[:kernel_vm][:image_storage], 'templates', File.basename(remote).sub('.box', '.qcow2'))
      )
    end
  end

  execute "kernel_vm raw box converter[#{File.basename(remote)}]" do
    command "VBoxManage clonehd --format RAW #{File.join(node[:kernel_vm][:image_storage], 'boxes', File.basename(remote).sub('.box', '.vmdk'))} #{File.join(node[:kernel_vm][:image_storage], 'boxes', File.basename(remote).sub('.box', '.raw'))}"
    creates File.join(node[:kernel_vm][:image_storage], 'templates', File.basename(remote).sub('.box', '.qcow2'))
  end

  execute "kernel_vm qcow raw converter[#{File.basename(remote)}]" do
    command "qemu-img convert -O qcow2 -f raw #{File.join(node[:kernel_vm][:image_storage], 'boxes', File.basename(remote).sub('.box', '.raw'))} #{File.join(node[:kernel_vm][:image_storage], 'boxes', File.basename(remote).sub('.box', '.qcow2'))}"
    creates File.join(node[:kernel_vm][:image_storage], 'templates', File.basename(remote).sub('.box', '.qcow2'))
  end

  execute "kernel_vm enable image[#{File.basename(remote).sub('.box', '.qcow2')}]" do
    command "mv #{File.join(node[:kernel_vm][:image_storage], 'boxes', File.basename(remote)).sub('.box', '.qcow2')} #{File.join(node[:kernel_vm][:image_storage], 'templates', File.basename(remote).sub('.box', '.qcow2'))}"
    creates File.join(node[:kernel_vm][:image_storage], 'templates', File.basename(remote).sub('.box', '.qcow2'))
  end

  # Don't keep the unpacked files around. They're huge
  file File.join(node[:kernel_vm][:image_storage], 'boxes', File.basename(remote).sub('.box', '.raw')) do
    action :delete
    backup false
  end
  file File.join(node[:kernel_vm][:image_storage], 'boxes', File.basename(remote).sub('.box', '.vmdk')) do
    action :delete
    backup false
  end
end

