require File.expand_path('../support/helpers', __FILE__)
require 'yaml'

describe 'cloudfoundry-dea::default' do
  include Helpers::CFDEA

  it 'installs the DEA to the target directory' do
    directory("/opt/test/dea").must_exist.with(:owner, 'cloudfoundry')
  end

  it 'creates the base data directory' do
    directory("/var/test/dea").must_exist.with(:owner, 'cloudfoundry')
  end

  it 'creates a valid config file' do
    file("/etc/cloudfoundry/dea.yml").must_exist # .with(:owner, 'cloudfoundry')
    YAML.load_file('/etc/cloudfoundry/dea.yml')
  end

  it 'creates a config file with the expected content' do
    config = YAML.load_file('/etc/cloudfoundry/dea.yml')
    {
      "base_dir"            => "/var/test/dea",
      "local_route"         => nil,
      "filer_port"          => 12345,
      "mbus"                => "nats://nats:nats@localhost:4222/",
      "intervals"           => {"heartbeat" => 10, "advertise" => 5},
      "logging"             => {"level" => "info", "file" => "/var/log/cloudfoundry/dea.log"},
      "max_memory"          => 4096,
      "secure"              => false,
      "multi_tenant"        => true,
      "pid"                 => "/var/run/cloudfoundry/dea.pid",
      "detect_port_timeout" => 120
    }.each do |k,v|
      config[k].must_equal v
    end
  end

  it 'creates a config file with the expected runtime' do
    config = YAML.load_file('/etc/cloudfoundry/dea.yml')
    config["runtimes"].class.must_equal Array
    config["runtimes"].must_equal ["canary"]
  end

  it 'creates a service init file' do
    file("/etc/init/cloudfoundry-dea.conf").must_exist # .with(:owner, 'cloudfoundry')
  end

  it 'enables the service' do
    service("cloudfoundry-dea").must_be_enabled
  end

  it 'starts the service' do
    service("/opt/test/dea/bin/dea").must_be_running  # XXX should be cloudfoundry-dea
  end
end
