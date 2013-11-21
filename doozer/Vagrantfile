# -*- coding: utf-8 -*-
Vagrant.configure("2") do |config|
  config.omnibus.chef_version = :latest

  config.vm.define :ubuntu1204 do |guest|
    guest.vm.box = 'opscode-ubuntu-12.04'
    guest.vm.box_url = 'https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box'
    guest.vm.hostname = 'ubuntu-12.04'
    guest.vm.network :private_network, :ip => '172.0.1.1'
    guest.vm.network :forwarded_port, :guest => 8080, :host => 8080
  end

  config.vm.define :centos64 do |guest|
    guest.vm.box = 'opscode-centos-6.4'
    guest.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_centos-6.4_provisionerless.box'
    guest.vm.hostname = 'centos-6.4'
    guest.vm.network :private_network, :ip => '172.0.1.2'
    guest.vm.network :forwarded_port, :guest => 8080, :host => 8081
  end

  config.vm.define :centos59 do |guest|
    guest.vm.box = 'opscode-centos-5.9'
    guest.vm.box_url = 'https://opscode-vm.s3.amazonaws.com/vagrant/opscode_centos-5.9_provisionerless.box'
    guest.vm.hostname = 'centos-5.9'
    guest.vm.network :private_network, :ip => '172.0.1.3'
    guest.vm.network :forwarded_port, :guest => 8080, :host => 8082
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 512]
    vb.customize ["modifyvm", :id, "--cpus", 4]
    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'iptables'
    chef.add_recipe 'mercurial'
    chef.add_recipe 'golang'
    chef.add_recipe 'doozer'
    chef.add_recipe 'doozer::doozer'
    chef.add_recipe 'doozer::iptables'
    chef.json = {
      'go' => {
        'platform' => 'amd64',
        'version' => '1.1'
      }
    }
  end
end
