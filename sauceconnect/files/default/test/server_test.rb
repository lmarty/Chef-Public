require 'minitest/spec'

describe_recipe 'sauceconnect::server' do

  it 'runs as a daemon' do
    service('sauceconnect').must_be_running
  end

end
