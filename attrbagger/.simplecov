SimpleCov.start do
  add_filter '/spec/'
end

SimpleCov.minimum_coverage Integer(ENV['MIN_COVERAGE'] || 85)
