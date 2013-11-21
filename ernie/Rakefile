

task "spec" do
  sh "rspec spec"
end

task "foodcritic" do
  sh "foodcritic ."
end

task "default" => ["foodcritic", "spec"]
