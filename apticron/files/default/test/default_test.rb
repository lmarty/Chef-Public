require 'minitest/spec'

# Cookbook name::apticron
# Spec:: default

describe_recipe 'apticron::default' do
  describe 'ensures apticron is installed' do
    let(:binary) { file("/usr/sbin/apticron") }
    it { binary.must_have(:mode, "0755") }
    it { binary.must_have(:owner, "root") }
  end

  describe 'ensures apticron.conf config is present' do
    let(:config) { file(node['apticron']['config_file']) }
    it { config.must_have(:mode, "0644") }
    it { config.must_have(:owner, "root") }
    it { config.must_include "EMAIL=#{node['apticron']['email']}" }
  end
end
