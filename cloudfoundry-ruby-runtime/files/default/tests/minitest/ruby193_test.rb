require File.expand_path('../support/helpers', __FILE__)

describe 'cloudfoundry-ruby-runtimes::ruby193' do
  include Helpers::CloudfoundryRubyRuntime

  it 'installs ruby 1.9.3 in rbenv' do
    directory("/opt/rbenv/versions/#{node['cloudfoundry_ruby_runtime']['ruby193']['version']}").must_exist
  end
end
