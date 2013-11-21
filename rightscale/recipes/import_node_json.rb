# Cookbook Name:: rightscale
# Recipe:: import_node_json
#
# Copyright 2012, Chris Fordham
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "rest_connection"

ruby_block "import_node_json" do
  block do
require 'rest_connection'
require 'json'

instance_id = File.read('/var/spool/cloud/meta-data/instance-id')

server = Server.find_with_filter('aws_id' => "#{instance_id}")[0]
puts server.to_yaml
  
# get current instance of server
server.reload_current
puts JSON.pretty_generate(server.settings)

# assign inputs from server params
inputs = server.parameters
puts "#{JSON.pretty_generate(inputs)}"
server_attributes = Hash.new
inputs.each { |input,v|
  if inputs.to_s =~ /^[A-Z]+$/
    puts "right_script input #{k} discarded."
  else
    puts "#{input} => #{v}"
    keys = input.split("/")
    if keys.count == 2
      type = v.split(':')[0] 
      value = v.split(':')[1]
      value = '' unless value != "$ignore"
      if keys[0] != 'rightscale'
          puts "node attribute #{keys[1]} detected for cookbook, #{keys[0]}."
          puts "attribute:#{keys[0]}[\"#{keys[1]}\"] type:#{type} value:#{value}"
          puts "[#{keys[0]}][#{keys[1]}] => type: #{type}"
          puts "[#{keys[0]}][#{keys[1]}] => value: #{value}"
          server_attributes["#{keys[0]}"] = {} unless server_attributes["#{keys[0]}"]
          server_attributes["#{keys[0]}"]["#{keys[1]}"] = "#{value}"
        end
      end
    end
  }
  puts "\n#{p server_attributes}", 'debug'
elsif opts[:template]
  # steal inputs from ST

  logger.log "Importing rest_connection Rubygem.."
  require 'rest_connection'

  template = false
  
  if opts[:template].to_i > 0
    logger.log "Finding ServerTemplate: #{opts[:template]}"
    template = ServerTemplate.find(opts[:template].to_i)
  else
    logger.log "Finding ServerTemplate: '%#{opts[:template]}%'"
    #puts ServerTemplate.find(:first).inspect; exit
    template = ServerTemplate.find(:first) { |s| s.nickname =~ /"#{opts[:template]}"/ }
  end
  
  if template  
    logger.log "ServerTemplate: #{template.to_yaml}", 'debug'
    executables = template.executables
    recipes = Array.new
    executables.each { |exec|
      if exec['apply'] == 'boot' and exec['recipe']
        logger.log "detected recipe: #{exec['recipe']}", 'debug'
        recipes.push(exec['recipe'])
      end
    }
    logger.log "Recipes array: #{recipes.to_json}", 'debug'
    run_list = "[ #{recipes.map {|element| '"'+"recipe[#{element}]"+'"' }.join(', ')} ]"
    logger.log "Run List from ST: #{run_list}", 'verbose'
    opts[:run] = run_list
    #puts opts[:run]
  else
    logger.log "No template found."
    exit 1
  end
end

# merge attributes
if server_attributes
  puts server_attributes.to_json
  logger.log "Merging attributes.", 'debug'
  attributes = server_attributes.merge(attributes)
else
  logger.log "No server attributes to merge.", 'debug'
end

# override runlist if set
if opts[:run]
  logger.log "Overriding run_list with: #{opts[:run]}", 'verbose'
  attributes['run_list'] = "#{opts[:run]}"
end

  end
end
