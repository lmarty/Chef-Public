# encoding: utf-8

$ubuntu_inline_script = <<EOF
export DEBIAN_FRONTEND=noninteractive
apt-get update -y -qq
apt-get install -y -qq git build-essential

if [ ! -d /tmp/example-app/.git ] ; then
  pushd /tmp
  rsync -avz /vagrant/test/integration/example-app .
  pushd ./example-app
  git init .
  git add .
  git config user.name Vagrant
  git config user.email vagrant@example.com
  git commit -m 'Initial commit'
fi

chown -R dreadnot:dreadnot /tmp/example-app
EOF

Vagrant.configure('2') do |config|
  config.vm.hostname = 'dreadnot-berkshelf'
  config.vm.box = 'canonical-ubuntu-12.04'
  config.vm.box_url = 'http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box'
  config.vm.network :private_network, ip: '33.33.33.10'

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.provision :shell, inline: $ubuntu_inline_script
  config.vm.provision :chef_solo do |chef|
    chef.log_level = ENV['DEBUG'] ? :debug : :info
    chef.json = {
      'dreadnot' => {
        'instances' => {
          'example-app' => {
            'git_repository' => '/tmp/example-app',
            'git_revision' => 'master'
          }
        }
      }
    }
    chef.run_list = [
      'recipe[dreadnot::default]'
    ]
  end
end
