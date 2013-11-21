require 'chefspec'

describe 'rayo::configure_node' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'rayo::configure_node' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
