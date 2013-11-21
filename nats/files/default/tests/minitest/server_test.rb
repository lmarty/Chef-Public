require File.expand_path('../support/helpers', __FILE__)

describe 'nats::server' do
  include Helpers::Nats

  it 'creates a config file' do
    file('/etc/cloudfoundry/nats-server.yml').must_exist # FIXME .with(:owner, 'cloudfoundry')
  end

  it 'contains the expected defaults' do
    config_file = file('/etc/cloudfoundry/nats-server.yml')
    config_file.must_match %r{^net: 0.0.0.0$}
    config_file.must_match %r{^port: 4222$}
    config_file.must_match %r{^pid_file: /var/run/cloudfoundry/nats-server.pid$}
    config_file.must_match %r{^log_file: /var/log/cloudfoundry/nats-server.log$}
    config_file.must_match %r{^  user: nats$}
    config_file.must_match %r{^  password: nats$}
  end

  it 'creates an upstart config file' do
    file('/etc/init/nats-server.conf').must_exist # FIXME .with(:owner, 'root')
  end

  it 'contains the expected config' do
    upstart_file = file('/etc/init/nats-server.conf')
    upstart_file.must_match %r{^description\s+.+$}
    upstart_file.must_match %r{^author\s+.+$}
    upstart_file.must_match %r{^start on \(net-device-up.*and filesystem.*and runlevel \[2345\]\)$}m
    upstart_file.must_match %r{^stop on runlevel \[016\]$}
    upstart_file.must_match %r{^env PATH="/opt/rbenv/versions/1.9.3-p286/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"$}
    upstart_file.must_match %r{^export PATH$}
    upstart_file.must_match %r{^pre-start script
  mkdir -p `dirname '/var/run/cloudfoundry/nats-server.pid'`
  chown cloudfoundry:cloudfoundry `dirname '/var/run/cloudfoundry/nats-server.pid'`
end script$}m
    upstart_file.must_match %r{^exec start-stop-daemon --start --chuid cloudfoundry --pid /var/run/cloudfoundry/nats-server.pid --startas /opt/rbenv/versions/1.9.3-p286/bin/ruby -- /opt/rbenv/versions/1.9.3-p286/bin/nats-server -c /etc/cloudfoundry/nats-server.yml}
  end
end
