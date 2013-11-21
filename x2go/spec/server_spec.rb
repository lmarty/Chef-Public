require 'chefspec'

describe 'x2go::server' do
  let(:chef_run) {
    ChefSpec::ChefRunner.new.converge 'x2go::server'
  }
  
  it 'installs x2go server' do
    expect(chef_run).to install_package 'x2goserver'
  end
  
  it 'enables x2go session cleanup  service' do
    expect(chef_run).to set_service_to_start_on_boot 'x2gocleansessions'
  end
  
  it 'starts x2go session cleanup service' do
    expect(chef_run).to start_service 'x2gocleansessions'
  end

end