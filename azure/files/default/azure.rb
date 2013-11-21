#
# Copyright (C) 2013 Panagiotis Papadomitsos
# 
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'resolv'

provides 'azure'
provides 'cloud'

require_plugin 'hostname'
require_plugin 'network'

# Infer the instance type from the memory available
def instance_memory
  memory[:total].to_i / 1024
end

def retrieve_instance_type
  instance_type = if instance_memory >= 32768
    'A7'
  elsif instance_memory >= 16384
    'A6'
  elsif instance_memory >= 8192
    'Extra Large'
  elsif instance_memory >= 4096
    'Large'
  elsif instance_memory >= 2048
    'Medium'
  elsif instance_memory >= 1024
    'Small'
  elsif instance_memory >= 512
    'Extra Small'
  else
    'Unknown'
  end
  instance_type
end

# Infer the instance code again from the memory available
def retrieve_instance_code
  instance_code = if instance_memory >= 32768
    'A7'
  elsif instance_memory >= 16384
    'A6'
  elsif instance_memory >= 8192
    'A4'
  elsif instance_memory >= 4096
    'A3'
  elsif instance_memory >= 2048
    'A2'
  elsif instance_memory >= 1024
    'A1'
  elsif instance_memory >= 512
    'A0'
  else
    'Unknown'
  end
  instance_code
end

# Extract information from resolv.conf
def retrieve_resolv_data
  resolv_data = ::File.read(::File.expand_path(::File.join('etc', 'resolv.conf'),'/')).
    split("\n").
    grep(/^search.*cloudapp.net$/).
    first.
    split.
    fetch(1).
    split('.') || nil rescue nil
  return nil if ((! resolv_data) || (! resolv_data[0]) || (! resolv_data[1]) || (! resolv_data[3]))
  {
    :deployment_id => resolv_data[0],
    :public_hostname => "#{resolv_data[1]}.cloudapp.net",
    :location => resolv_data[3]
  }
end

def retrieve_waagent_data
  if retrieve_instance_code.eql?('A0')
    # No resource disk for XS instances
    {
      :resource_disk => false
    }
  else
    # Parse the waagent.conf file in order to retrieve resource disk info
    waagent_hash = {}
    ::File.read(::File.join('etc', 'waagent.conf')).
      split("\n").
      map{ |line| if line.match(/^\s*#/) || line.strip.empty? then next else line end }.
      compact.
      map{ |line| line.split.first }.
      each{ |line| kv = line.split('='); waagent_hash[kv.shift] = kv.shift } || nil rescue nil
    return nil if ((! waagent_hash) || (waagent_hash.empty?))
    # The resource disk is always mounted on /dev/sdb1, IF mounted
    {
      :resource_disk => {
        :size       => {
          :kb       => (block_device[:sdb][:size].to_i * 512) / 1024,
          :mb       => (block_device[:sdb][:size].to_i * 512) / 1048576,
          :gb       => (block_device[:sdb][:size].to_i * 512) / 1073741824
        },
        :device     => '/dev/sdb1',
        :mount      => waagent_hash['ResourceDisk.Format'].eql?('y'),
        :filesystem => waagent_hash['ResourceDisk.Filesystem'],
        :mountpoint => waagent_hash['ResourceDisk.MountPoint'],
        :swap       => {
          :enabled    => waagent_hash['ResourceDisk.EnableSwap'].eql?('y'),
          :size       => waagent_hash['ResourceDisk.SwapSizeMB'].to_i
        }
      }
    }
  end
end

# Use the local resolver to resolve the hostname inferred from the search directive on resolv.conf
# Explicitly define the resolver we want to use because if we have defined our hostname in /etc/hosts
# then the class will use that and this may resolve in our local IP address
def retrieve_public_ipv4(public_hostname)
  ns = ::File.read(::File.expand_path(::File.join('etc', 'resolv.conf'),'/')).
    split("\n").
    grep(/^\s*nameserver/).
    first.
    split.
    fetch(1) || nil
  return nil unless ns
  resolver = Resolv::DNS.new(:nameserver => ns)
  resolver.getaddress(public_hostname).to_s
rescue
  nil
end

def prettify_location(location)
  location_pretty = {
    :asiaeast       => 'East Asia',
    :asiasoutheast  => 'Southeast Asia',
    :europewest     => 'West Europe',
    :europenorth    => 'North Europe',
    :useast         => 'East US',
    :uswest         => 'West US'
  }
  location_pretty[location.to_sym] || 'Unknown'
end

# Standard RPMs/DEBs use /etc/waagent.conf for configuration
def waagent_exists?
  ::File.exists?(::File.expand_path(::File.join('etc', 'waagent.conf'),'/')) && 
    (run_command(:no_status_check => true, :command => 'which waagent') rescue false)
end

def looks_like_azure?
  retrieve_resolv_data && waagent_exists?
end

if looks_like_azure?
  Ohai::Log.debug('looks_like_azure? = true')

  azure Mash.new unless azure
  cloud Mash.new unless cloud

  resolv_data               = retrieve_resolv_data
  public_ipv4               = retrieve_public_ipv4(resolv_data[:public_hostname])

  azure[:deployment_id]     = resolv_data[:deployment_id]
  azure[:instance_type]     = retrieve_instance_type
  azure[:instance_code]     = retrieve_instance_code
  
  azure[:public_hostname]   = resolv_data[:public_hostname]
  azure[:public_ipv4]       = public_ipv4
  
  azure[:local_hostname]    = fqdn
  azure[:local_ipv4]        = ipaddress
  
  azure[:location]          = resolv_data[:location]
  azure[:location_pretty]   = prettify_location(resolv_data[:location])

  azure[:resource_disk]     = retrieve_waagent_data.fetch(:resource_disk)

  cloud[:public_ips]        = [ azure[:public_ipv4] ]
  cloud[:private_ips]       = [ azure[:local_ipv4] ]

  cloud[:public_ipv4]       = azure[:public_ipv4]
  cloud[:local_ipv4]        = azure[:local_ipv4]
  
  cloud[:public_hostname]   = azure[:public_hostname]
  cloud[:local_hostname]    = azure[:local_hostname]

  cloud[:provider]          = 'azure'
else
  Ohai::Log.debug('looks_like_azure? == false')
  false
end
