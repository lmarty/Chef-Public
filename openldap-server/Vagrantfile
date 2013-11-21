Vagrant.configure("2") do |config|
  config.vm.hostname = "common-system-berkshelf"
  config.vm.box = "canonical-ubuntu-12.04"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  config.omnibus.chef_version = :latest
  config.vm.network :private_network, ip: "33.33.33.10"
  config.ssh.max_tries = 40
  config.ssh.timeout = 120
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
        "recipe[openldap-server::default]"
    ]
    chef.data_bags_path = '/var/chef/data_bags'
    chef.encrypted_data_bag_secret_key_path = '/tmp/encrypted_data_bag_secret'
  end
end
