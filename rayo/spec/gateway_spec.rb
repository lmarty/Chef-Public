require 'chefspec'

describe 'rayo::gateway' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'rayo::gateway' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
