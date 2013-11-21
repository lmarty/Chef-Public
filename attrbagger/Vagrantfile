Vagrant.configure('2') do |config|
  config.vm.hostname = 'attrbagger-berkshelf'

  config.vm.box = 'canonical-ubuntu-12.04'
  config.vm.box_url = 'http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box'

  config.vm.network :private_network, ip: '33.33.33.10'

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = 'Berksfile.vagrant'

  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.log_level = ENV['DEBUG'] ? :debug : :info
    chef.data_bags_path = 'data_bags'
    chef.cookbooks_path = ['vendor/cookbooks']
    chef.json = {
      'flurb' => {
        'foop' => {
          'buzz' => 2
        }
      },
      'fizz' => 'ham',
      'attrbagger' => {
        'autoload' => true,
        'configs' => {
          'flurb::foop' => {
            'precedence_level' => 'override',
            'bag_cascade' => [
              "data_bag_item[derps::<%= node['fizz'] %>]",
              'data_bag_item[noodles::foop]'
            ]
          },
          'bork' => {
            'precedence_level' => 'normal',
            'bag_cascade' => [
              'data_bag_item[ack]'
            ]
          }
        }
      }
    }

    chef.run_list = [
      'recipe[attrbagger]',
      'recipe[attrbagger_example]',
      'recipe[minitest-handler]'
    ]
  end
end
