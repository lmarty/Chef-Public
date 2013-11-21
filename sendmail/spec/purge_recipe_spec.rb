require 'chefspec'


describe 'sendmail::purge' do

  #= Lets ===

  let( :chef_run ){ ChefSpec::ChefRunner.new.converge 'sendmail::purge' }


  #= Specs ===

  it 'removes sendmail' do
    expect( chef_run ).to purge_package 'sendmail'
  end

  it 'stops sendmail' do
    expect( chef_run ).to stop_service 'sendmail'
  end

  it 'disables sendmail' do
    expect( chef_run ).to disable_service 'sendmail'
  end

end