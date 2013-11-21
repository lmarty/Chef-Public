if ENV['COVERAGE']
  require 'simplecov'
end

chef_libraries = File.expand_path('../../libraries', __FILE__)
unless $LOAD_PATH.include?(chef_libraries)
  $LOAD_PATH.unshift(chef_libraries)
end

require 'chef/log'
Chef::Log.level = ENV['DEBUG'] ? :debug : :error
