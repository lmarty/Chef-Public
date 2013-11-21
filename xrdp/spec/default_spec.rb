require 'chefspec'

describe 'xrdp::default' do
  
  let(:chef_run) do
    runner = ChefSpec::ChefRunner.new('platform' => 'ubuntu', 'version'=> '12.04')
    runner.converge('xrdp::default')
  end
    
  it 'should include the xrdp recipe by default' do
    expect(chef_run).to include_recipe 'xrdp::default'
  end

  it 'should include the server install recipe do' do
    expect(chef_run).to include_recipe 'xrdp::server'
  end

  context 'fedora' do 
    let(:chef_run) do
      runner = ChefSpec::ChefRunner.new('platform' => 'fedora', 'version'=> '19')
      runner.converge('xrdp::default')
    end

    it 'should include the server install recipe do' do
      expect(chef_run).to include_recipe 'xrdp::server'
    end
  end
  
end