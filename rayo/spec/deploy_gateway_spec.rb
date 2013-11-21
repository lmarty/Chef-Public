require 'chefspec'

describe 'rayo::deploy_gateway' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'rayo::deploy_gateway' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
