require 'chefspec'

describe 'x2go::default' do
  
  let(:chef_run) do
    runner = ChefSpec::ChefRunner.new('platform' => 'centos', 'version'=> '6.0')
    runner.node.set['x2go']['install_flavor'] = 'yum_repo'
    runner.converge('x2go::default')
  end
    
  it 'should include the x2go recipe by default' do
    expect(chef_run).to include_recipe 'x2go::default'
  end

  context 'rhel' do 
    let(:chef_run) do
      runner = ChefSpec::ChefRunner.new('platform' => 'rhel', 'version'=> '6.0')
      runner.node.set['x2go']['install_flavor'] = 'yum_repo'
      runner.converge('x2go::default')
    end

    it 'should include the recipe for yum if the machine is running CentOS/RHEL 6 and above' do
      expect(chef_run).to include_recipe 'x2go::yum_repo'
    end
  end
  
end