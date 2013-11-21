#!/usr/bin/env rake

require 'foodcritic'
require 'rake/testtask'
require 'rspec/core/rake_task'

FoodCritic::Rake::LintTask.new do |t|
  t.options = { :fail_tags => ['any'] }
end

RSpec::Core::RakeTask.new(:spec)

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts ">>>>> test-kitchen gem not loaded, omitting tasks" unless ENV['CI']
end

task :default => [:foodcritic, :spec]
