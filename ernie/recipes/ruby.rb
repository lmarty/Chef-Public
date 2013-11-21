case node.ernie.ruby
when "package"
  package "ruby"
  package "ruby-devel"
  package "rubygems"
when "rbenv"
  raise "TODO"
when "rvm"
  raise "TODO"
when "source"
  raise "TODO"
else
  raise "TODO"
end
