require 'chefspec'


describe 'sendmail::remove' do

  #= Lets ===

  let( :chef_run ){ ChefSpec::ChefRunner.new.converge 'sendmail::remove' }


  #= Specs ===

  it 'removes sendmail' do
    expect( chef_run ).to remove_package 'sendmail'
  end

  it 'stops sendmail' do
    expect( chef_run ).to stop_service 'sendmail'
  end

  it 'disables sendmail' do
    expect( chef_run ).to disable_service 'sendmail'
  end

end