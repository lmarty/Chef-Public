%w(
bundler/setup
guard/rspec
flexmock/rspec
fakeweb
logger
fog
json
json_spec
time
timecop
simplecov
dynect_rest
fakefs/spec_helpers
).each{|lib| require lib}

SimpleCov.start

FakeWeb.allow_net_connect = false

$:.push File.dirname(__FILE__) + "/../"

# Logging in chef w/ puts ( dont ask questions), and for the tests we are sweeping this under the rug... again, dont ask questions...
# todo:  Find a better way to log in chef libraries
def puts(*args); nil; end


RSpec.configure do |config|
  config.mock_framework = :flexmock
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.color_enabled = true
  config.mock_with :rspec
  config.include FakeFS::SpecHelpers, fakefs: true
end
