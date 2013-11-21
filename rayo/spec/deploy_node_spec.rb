require 'chefspec'

describe 'rayo::deploy_node' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'rayo::deploy_node' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
