require_plugin "rackspace"

def get_networks
  status, stdout, stderr = run_command(:no_status_check => true, :command => 'xenstore-ls vm-data/networking')
  if status == 0
    stdout.split("\n").map{|l| l.split('=').first.strip }.map do |item|
      _status, _stdout, _stderr = run_command(:no_status_check => true, :command => "xenstore-read vm-data/networking/#{item}")
      if status == 0
        Yajl::Parser.new.parse(_stdout)
      else
        raise Ohai::Exceptions::Exec
      end
    end
  end
rescue Ohai::Exceptions::Exec
  Ohai::Log.debug('Unable to capture custom private networking information for Rackspace cloud')
end

# Adds rackspace network information
# Only add information if not already provided (this feature should be
# upstream at some point)
# http://tickets.opscode.com/browse/OHAI-461
if looks_like_rackspace? && rackspace[:networks].nil?
  rackspace[:networks] = get_networks
end
