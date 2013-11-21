require File.expand_path('../support/helpers', __FILE__)

describe 'cloudfoundry-stager::default' do
  include Helpers::CloudfoundryStager

  it 'installs the stager to the target directory' do
    directory("/srv/vcap-stager").must_exist.with(:owner, 'cloudfoundry')
  end

  it 'creates a valid config file' do
    file("/etc/cloudfoundry/stager.yml").must_exist # .with(:owner, 'cloudfoundry')
    YAML.load_file('/etc/cloudfoundry/stager.yml')
  end

  it 'creates a config file with the expected content' do
    config = YAML.load_file('/etc/cloudfoundry/stager.yml')
    {
      "nats_uri"                  => "nats://nats:nats@localhost:4222/",
      "logging"               => {"level" => "info", "file" => "/var/log/cloudfoundry/stager.log"},
      "pid_filename"          => "/var/run/cloudfoundry/stager.pid",
      "max_staging_duration"  => 120,
      "max_active_tasks"      => 10,
      "queues"                => ["staging"],
      "dirs"                  => {"tmp" => "/var/vcap/data/stager/tmp"},
      "ruby_path"             => "/opt/rbenv/versions/1.9.3-p286/bin/ruby",
      "secure"                => false
    }.each do |k,v|
      config[k].must_equal v
    end
  end

  it 'creates a platform file' do
    file("/etc/cloudfoundry/platform.yml").must_exist # .with(:owner, 'cloudfoundry')
    platform = YAML.load_file('/etc/cloudfoundry/platform.yml')
    platform['cache'].must_equal "/var/vcap/data/stager/package_cache/ruby"
  end

  it 'creates a service init file' do
    file("/etc/init/cloudfoundry-stager.conf").must_exist # .with(:owner, 'cloudfoundry')
  end

  it 'enables the service' do
    service("cloudfoundry-stager").must_be_enabled
  end

  it 'starts the service' do
    service("/srv/vcap-stager/bin/stager")
  end
end
