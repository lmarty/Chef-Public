# encoding: utf-8

require File.expand_path('../support/helpers', __FILE__)

describe_recipe 'lmctfy::source' do
  include Helpers::Lmctfy

  it 'installs lmctfy binary' do
    file("#{node['lmctfy']['install_dir']}/bin/lmctfy").must_exist
  end
end
