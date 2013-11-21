require 'chefspec'

describe 'x2go::client' do
  let(:chef_run) {
    ChefSpec::ChefRunner.new.converge 'x2go::client'
  }
  
  it 'installs x2go client' do
    expect(chef_run).to install_package 'x2goclient'
  end
end