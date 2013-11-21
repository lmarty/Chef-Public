require 'chefspec'

describe 'xrdp::server' do
  let(:chef_run) {
    ChefSpec::ChefRunner.new.converge 'xrdp::server'
  }
  
  it 'installs xrdp server' do
    expect(chef_run).to install_package 'xrdp'
  end
  
  it 'enables xrdp service' do
    expect(chef_run).to set_service_to_start_on_boot 'xrdp'
  end
  
  it 'starts xrdp  service' do
    expect(chef_run).to start_service 'xrdp'
  end

end