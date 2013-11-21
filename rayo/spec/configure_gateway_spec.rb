$:.push File.dirname(__FILE__); require 'spec_helper'
require 'chefspec'

describe 'rayo::configure_gateway' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'rayo::configure_gateway' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
