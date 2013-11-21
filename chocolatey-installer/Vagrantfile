# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "chocolatey-installer-berkshelf"
  config.vm.box = "windows2008r2"
  
  # Berkshelf
  config.berkshelf.enabled = true
  
  # Windows
  config.windows.halt_timeout = 20
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"  
  config.vm.guest = :windows
  config.vm.network :forwarded_port, guest: 5985, host: 5985


  # Provision
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug
    chef.file_cache_path = "c:/chef/cache"
    chef.file_backup_path = "c:/chef/backup"
    chef.add_recipe "windows::default"
    chef.add_recipe "minitest-handler::default"
    chef.add_recipe "windows::reboot_handler"
    chef.add_recipe "chocolatey-installer::default"
    chef.json = {
      "chocolatey-installer"=>{
        "packages"=> ['git', 'notepadplusplus']
      },
      "windows"=>{
        "reboot_timeout" => 15
      }
    }
  end
  
  config.vm.provider :virtualbox do |v, override|
  end

  config.vm.provider :vmware_fusion do |v, override|
    v.gui = true
    v.vmx["memsize"] = "2048"
    v.vmx["ethernet0.virtualDev"] = "vmxnet3"
    v.vmx["RemoteDisplay.vnc.enabled"] = "false"
    v.vmx["RemoteDisplay.vnc.port"] = "5900"
  end

  config.vm.provider :vmware_workstation do |v, override|
    v.gui = true
    v.vmx["memsize"] = "2048"
    v.vmx["ethernet0.virtualDev"] = "vmxnet3"
    v.vmx["RemoteDisplay.vnc.enabled"] = "false"
    v.vmx["RemoteDisplay.vnc.port"] = "5900"
  end
end
