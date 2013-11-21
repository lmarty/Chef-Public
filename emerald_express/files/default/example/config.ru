require "rubygems"
require "sinatra"

get "/" do
  "Emerald!"
end

run Sinatra::Application
