# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "chef-phpbb-berkshelf"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "Ubuntu12.04.2-i386-chef11"

  config.vm.network :private_network, ip: "33.33.33.10"


  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass'
      }
    }

    chef.run_list = [
        "recipe[minitest-handler::default]",
        "recipe[phpbb::default]"
    ]
  end
end
