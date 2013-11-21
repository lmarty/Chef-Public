require File.expand_path('../support/helpers', __FILE__)

describe 'nats::client' do
  include Helpers::Nats

  it 'installs the ruby gem' do
    if node['platform_version'].to_f <= 10.04
      Chef::Log.info "nats::client is not supported on this system"
      return
    end

    gems = `/usr/bin/gem list`.split("\n")
    nats_gem = gems.select { |g| g =~ /^nats/ }
    nats_gem.must_equal [ "nats (0.4.28)" ]
  end
end
