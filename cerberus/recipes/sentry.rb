#
# Cookbook Name:: cerberus
# Recipe:: sentry
#
# Author:: Steven Craig <support@smashrun.com>
# Copyright 2013, Smashrun, Inc.
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
#
# http://technet.microsoft.com/en-us/library/cc737845(WS.10).aspx
# http://technet.microsoft.com/en-us/library/bb490621.aspx
# http://www.microsoft.com/download/en/confirmation.aspx?id=18996
#

log("begin sentry") { level :debug }
log("running sentry") { level :info }

log("Begin registry search for current firewall rules") {level :info}
    # firewall rules are stored inside two places inside the registry: CurrentControlSet and ControlSet001
    # grab all keys that start with a brace (system rules dont have braced, GUID key-names) from:
    # HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules
    # slurp and then discard first item (version of rule); then split contents by pipe / equals
    # check Name= for "cerberus_" and push onto array
regbase = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\FirewallRules'
current_rule = []
current_rule_hash = {}
value_array = registry_get_values(regbase, :machine)
log("Found registry info for #{value_array.length} Total firewall rules") {level :info}
value_array.each do |value|
  if "#{value[:name]}" =~ /^\{.*/
    #log("found rule name #{value[:name]} contains #{value[:data]}") {level :debug}
    value[:data].split('|').each do |x|
      k,v = x.split('=')
      if "#{v}" =~ /^cerberus_/
        #log("#{value[:name]} is GUID for cerberus fw rule #{v}") {level :debug}
        current_rule_hash["#{value[:name]}"] = "#{v}"
      end
    end
  end
end

#current_rule_hash.each do |key,value|
#  log("registry GUID #{key} maps to firewall name #{value}") {level :debug}
#end

log("Found registry info for #{current_rule_hash.length} current cerberus-managed firewall rules") {level :info}

log("Begin search for new or updated firewall rules") { level :debug }
cerberus_bag = CerberusDataBag.new
ip_permit = cerberus_bag.get('ip_permit')
firewall_rules = cerberus_bag.get('firewall_rules')
ip_list = []
authoritative_rule_list = []

if cerberus_bag.bag_list.include?('ip_permit')
  search(:ip_permit, "*:*") do |ip|
    permit_details = { "id" => ip["id"],
      "comment" => ip["comment"],
      "fqdn" => ip["fqdn"],
      "ipaddress" => ip["ipaddress"],
      "netmask" => ip["netmask"],
      "owner" => ip["owner"]
    }
    permit = ip["ipaddress"] + ip["netmask"]
    ip_list << permit
    ip_permit << permit_details
  end
end

if cerberus_bag.bag_list.include?('firewall_rules')
  search(:firewall_rules, "*:*") do |rule|
    policy = { "id" => rule["id"],
      "name" => rule["name"],
      "description" => rule["description"],
      "permit" => rule["permit"],
      "protocol" => rule["protocol"]
    }
    firewall_rules << policy
  end
end

log("End search for new or updated firewall rules") { level :debug }
log("Found #{ip_permit.length.to_s} ipaddresses or blocks inside authoritative ip_permit data bag") {level :info}
log("Found #{firewall_rules.length.to_s} base firewall rules inside authoritative firewall_rules data bag") {level :info}

if "#{node['firewall']['logging']}" == "true"
  log("enable #{node['firewall']['servicename']} logging dropped connections") { level :debug }
  ["droppedconnections enable", "maxfilesize 32767"].each do |cmdsuffix|
    execute "netsh_logging-enable-#{cmdsuffix}" do
      cwd "#{node['kernel']['os_info']['system_directory']}"
      command "#{node['kernel']['os_info']['system_directory']}\\netsh advfirewall set allprofiles logging #{cmdsuffix}"
      ignore_failure true 
      timeout 30
      action :nothing
    end
  end
  
else
  log("disable #{node['firewall']['servicename']} logging dropped connections") { level :debug }
  execute "netsh_logging-disable" do
    cwd "#{node['kernel']['os_info']['system_directory']}"
    command "#{node['kernel']['os_info']['system_directory']}\\netsh advfirewall set allprofiles logging droppedconnections disable"
    ignore_failure true 
    timeout 30
    action :nothing
  end
end

["80","443"].each do |port|
  case node[:hostname]
  when /pww/i
    sentry_json "cerberus_http-tcp-#{port}-ALL" do
      variables(:rule => { 'name' => "cerberus_http-tcp-#{port}-ALL", 'permit' => 'enabled', 'description' => "\\\"Microsoft IIS webserver ALL access (tcp http #{port})\\\"" , 'id' => port }, :ip => {'ipaddress' => '*', 'netmask' => ""}, :protocol => 'tcp')
    end
    authoritative_rule_list << "cerberus_http-tcp-#{port}-ALL"

  when /[dq]ww/i
    sentry_json "cerberus_http-tcp-#{port}-smashrun-internal" do
      variables(:rule => { 'name' => "cerberus_http-tcp-#{port}-smashrun-internal", 'permit' => 'enabled', 'description' => "\\\"Microsoft IIS webserver smashrun internal access (tcp http #{port})\\\"", 'id' => port }, :ip => {'ipaddress' => "#{ip_list.join(',')}", 'netmask' => ""}, :protocol => 'tcp')
    end
    authoritative_rule_list << "cerberus_http-tcp-#{port}-smashrun-internal"

    node[:firewall][:exception].each do |f|
      sentry_json "cerberus_http-tcp-#{port}-#{f[:name]}-access" do
        variables(:rule => { 'name' => "cerberus_http-tcp-#{port}-#{f[:name]}-access", 'permit' => 'enabled', 'description' => "\\\"Microsoft IIS webserver #{f[:name]} access (tcp http #{port})\\\"", 'id' => port }, :ip => {'ipaddress' => "#{f[:range]}", 'netmask' => ""}, :protocol => 'tcp')
      end
    authoritative_rule_list << "cerberus_http-tcp-#{port}-#{f[:name]}-access"
    end

  end
end

ip_permit.each do |ip|
  sentry_json "cerberus_echorequest-icmp-#{ip['ipaddress']}#{ip['netmask'].gsub(/^\//,'-')}" do
    variables(:rule => { 'name' => "cerberus_echorequest-icmp-#{ip['ipaddress']}#{ip['netmask'].gsub(/^\//,'-')}", 'permit' => 'enabled', 'description' => 'icmp-echo-request' }, :ip => ip, :protocol => 'icmpv4:8,any')
  end
  authoritative_rule_list << "cerberus_echorequest-icmp-#{ip['ipaddress']}#{ip['netmask'].gsub(/^\//,'-')}"
end

firewall_rules.each do |rule|
  if rule['protocol'] =~ /ip/
    ['tcp','udp'].each do |multi|
      ip_permit.each do |ip|
        sentry_json "cerberus_#{rule['name']}-#{multi}-#{rule['id']}-#{ip['ipaddress']}#{ip['netmask'].gsub(/^\//,'-')}" do
          variables(:rule => { 'name' => "cerberus_#{rule['name']}-#{multi}-#{rule['id']}-#{ip['ipaddress']}#{ip['netmask'].gsub(/^\//,'-')}", 'description' => rule['description'], 'id' => rule['id'] }, :ip => ip, :protocol => "#{multi}")
        end
        authoritative_rule_list << "cerberus_#{rule['name']}-#{multi}-#{rule['id']}-#{ip['ipaddress']}#{ip['netmask'].gsub(/^\//,'-')}"
      end
    end
  else
    ip_permit.each do |ip|
      sentry_json "cerberus_#{rule['name']}-#{rule['protocol']}-#{rule['id']}-#{ip['ipaddress']}#{ip['netmask'].gsub(/^\//,'-')}" do
        variables(:rule => { 'name' => "cerberus_#{rule['name']}-#{rule['protocol']}-#{rule['id']}-#{ip['ipaddress']}#{ip['netmask'].gsub(/^\//,'-')}", 'description' => rule['description'], 'id' => rule['id'] }, :ip => ip, :protocol => rule['protocol'])
      end
      authoritative_rule_list << "cerberus_#{rule['name']}-#{rule['protocol']}-#{rule['id']}-#{ip['ipaddress']}#{ip['netmask'].gsub(/^\//,'-')}"
    end
  end
end
log("End import current firewall rules") {level :info}

authoritative_rule_list.sort!
authoritative_rule_list.uniq!

log("Current authoritiative cerberus rule list contains #{authoritative_rule_list.length} firewall rules") {level :info}
log("Begin deprecated firewall rule removal, if necessary") {level :debug}
# first, build the "remove" list of tasks we know must be removed this run
# (because they no longer exist inside the authoritative chef data bag)
remove = current_rule_hash.collect {|x| "#{x[1]}"} - authoritative_rule_list
unless remove.length == 0
  log("Found #{remove.length} currently scheduled, cerberus-managed firewall rules to be removed this run") {level :info}
end

# firewall rules inside the "remove" array need to be unregistered via advfirewall control
remove.each do |d|
  execute "remove-firewall-rule-#{d}" do
    cwd node['firewall']['jsonconf']
    command %Q(#{node['kernel']['os_info']['system_directory']}\\netsh advfirewall firewall delete rule name=#{d})
    action :run
    timeout 6
  end
end

# next, find any orphaned firewall json files that might be "left-over" inside jsonconf directory
# this list could (and should, in most cases) overlap with the "remove" list
# but if there is an unclean run, or - more likely - if a person mucked about
# with the registry, or the chef cache, this will clean that up, too
orphan = []
begin
  if node['firewall']['jsonconf']
    Dir.chdir(node['firewall']['jsonconf'])
    file = Dir["*"].reject{|o| File.directory?(o)}
    t = file.collect {|x| x.gsub(/\.json$/,'')}
    orphan = t - authoritative_rule_list
  else
    puts "node['firewall']['jsonconf'] is required"
  end
rescue Exception => e
  Chef::Log.warn("Error in cookbook cerberus::sentry #{e}")
  Chef::Log.warn("This is expected behaviour on the initial run #{e}")
end

unless orphan.length == 0
  log("Found #{orphan.length} orphaned, cerberus-managed json firewall files to be removed this run") {level :info}
end

# last, add the remove and orphan lists together and unique them
# so that the contents can be deleted from the node
# known tasks for removal will need their xml files deleted
# unknown xml files could also potentially accumulate and could require removal as well
delete = remove + orphan
delete.uniq!
unless delete.length == 0
  log("Deleting #{delete.length} cerberus-managed json firewall files inside #{node['firewall']['jsonconf']}") {level :info}
end
delete.each do |d|
  execute "delete-firewall-file-#{d}.json" do
    cwd "#{node['firewall']['jsonconf']}"
    command %Q(del /F /S /Q "#{node['firewall']['jsonconf']}\\#{d}.json")
    action :run
    timeout 3
  end
end

log("End deprecated firewall rule removal") {level :debug}

# i need a library here
# that will read a json file in
# check a few conditions (to correctly setup an advfirewall command)
# and create the proper advfirewall command string
#
# then i construct a ruby_block for all the authoritative firewall rules
# with action :nothing
# and notify it by the sentry_json method
# the ruby_block will create a new Advfirewall object

# now create and update individual json files, one per task
authoritative_rule_list.each do |fw|
  ruby_block "apply-#{fw}.json" do
    block {
      rule = Advfirewall.new("#{node['firewall']['jsonconf']}\\#{fw}.json")
    }
    ignore_failure false
    action :nothing
  end
end

# on windows 2008, if the template does not change, chef does not reload the rule
# this is nice for efficiency; however, it means that if someone deletes the rule locally,
# the node[:schedule][:workingdir] folder would need to be deleted before chef would re-create them
# the "double-check" ensures these are re-registered each run
double_check = authoritative_rule_list - current_rule_hash.collect {|x| "#{x[1]}"}
double_check.each do |t|
  ruby_block "double-check-#{t}.json" do
    block {
      rule = Advfirewall.new("#{node['firewall']['jsonconf']}\\#{t}.json")
    }
    ignore_failure false
    action :run
  end
end

log("end sentry") { level :info }
