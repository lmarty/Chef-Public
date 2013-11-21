require 'minitest/spec'
#
## Cookbook Name:: minecraft
## Spec:: mark2

describe_recipe 'minecraft::mark2' do
  it 'ensures mark2 is installed' do
    result = assert_sh('mark2')
    assert_includes result, 'usage: mark2'
  end

  describe 'ensures mark2 directory exists with proper permissions' do
    let(:dir) { directory('/etc/mark2') }
    it { dir.must_have(:mode, '0755') }
    it { dir.must_have(:owner, node['minecraft']['user']) }
    it { dir.must_have(:group, node['minecraft']['group']) }
  end

  describe 'ensures the global mark2 config exists' do
    let(:config) { file('/etc/mark2/mark2.properties') }
    it { config.must_have(:mode, '0644') }
    it { config.must_have(:owner, node['minecraft']['user']) }
    it { config.must_have(:group, node['minecraft']['group']) }
  end

  describe 'ensures the local mark2 config exists' do
    let(:config) { file("#{node['minecraft']['install_dir']}/mark2.properties") }
    it { config.must_have(:mode, '0644') }
    it { config.must_have(:owner, node['minecraft']['user']) }
    it { config.must_have(:group, node['minecraft']['group']) }
  end

  describe 'ensures the local mark2 config contains properties we set' do
    let(:config) { file("#{node['minecraft']['install_dir']}/mark2.properties") }
    it { config.must_include 'mark2.shutdown-timeout=60' }
    it { config.must_include 'plugin.backup.enabled=false' }
    it { config.must_include "java.cli.X.ms=#{node['minecraft']['xms']}" }
    it { config.must_include "java.cli.X.ms=#{node['minecraft']['xmx']}" }
  end

end
