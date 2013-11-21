emerald do
  base_path File.expand_path(File.dirname(__FILE__) + '/../../sandbox')
  gemfile 'example/Gemfile'
  files ["example/config.ru"]
  commands start: "bundle exec bin/puma --port 8080"
end
