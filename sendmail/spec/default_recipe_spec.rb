require 'chefspec'


describe 'sendmail::default' do

  #= Lets ===

  let( :chef_run ){ ChefSpec::ChefRunner.new.converge 'sendmail::default' }


  #= Specs ===

  it 'installs sendmail' do
    expect( chef_run ).to install_package 'sendmail'
  end

  it 'starts sendmail' do
    expect( chef_run ).to start_service 'sendmail'
  end

  it 'enables sendmail' do
    expect( chef_run ).to enable_service 'sendmail'
  end

end