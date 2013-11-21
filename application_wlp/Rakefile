require 'rake/clean'

task :default => :all

task :all => [:knife_test, :foodcritic]

task :syntax => :knife_test

desc "Runs 'knife cookbook test'"
task :knife_test do
  sh "bundle exec knife cookbook test -o .. #{cookbook_name}"
end

desc "Runs 'foodcritic'"
task :foodcritic do
  sh "bundle exec foodcritic ."
end

desc "Runs 'kitchen test'"
task :kitchen do
  sh "bundle exec kitchen test"
end

def cookbook_name
  File.basename(File.dirname(__FILE__))
end
