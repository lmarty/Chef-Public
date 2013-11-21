require 'chefspec'

describe 'pycharm-community-edition::default' do
  let(:chef_run) {
    ChefSpec::ChefRunner.new.converge 'pycharm-community-edition::default'
  }
  
  it 'installs the PyCharm Community Edition' do
    expect(chef_run).to install_windows_package 'PyCharm Community Edition'
  end
end