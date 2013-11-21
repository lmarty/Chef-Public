require File.expand_path('../support/helpers', __FILE__)

describe 'cloudfoundry-ruby-runtimes::ruby18' do
  include Helpers::CloudfoundryRubyRuntime

  it 'installs ruby 1.8.7 in rbenv' do
    directory("/opt/rbenv/versions/#{node['cloudfoundry_ruby_runtime']['ruby18']['version']}").must_exist
  end
end
