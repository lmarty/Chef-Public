use_inline_resources if defined?(use_inline_resources)

action :add do
  if @device.nil?
      #ip_address = new_resource.ip || node['ipaddress']
      new_device_rsp = @connection.json_request(
        'DeviceRouter', 'addDevice', 
          [{:deviceName => @new_resource.name, 
          :deviceClass => new_resource.device_class,
          :manageIp => new_resource.ip,
          :collector => new_resource.collector,
          :comments => new_resource.comments
          
          }]
      )
      if new_device_rsp.has_key?("success") && new_device_rsp['success'] == true
        # At this point all we really know is that the Zenoss API 'accepted'
        # our request. Zenoss will do most of this work in the background
        # so the only way to be sure it worked is to wait for it to show up
        # this can be slow, so we let the user decided if we block or 
        # fire and forget, defaulting to the later
        if new_resource.wait_for > 0
          # Its been requested that we block until it shows up, or until
          # the timeout expires
          found_device  = false
          sleep_int = 5 #seconds
          retries = (new_resource.wait_for / sleep_int).ceil
          while found_device == false
            if retries > 0
              if get_device().nil?
                retries -= 1
                Chef::Log.debug("Newly added device, still not showing up")
                sleep(sleep_int)
              else
                found_device = true
              end
            else
              Chef::Log.error("Newly added device has not appeared" + 
              " within the requested wait time of #{new_resource.wait_for}")
              # The dilema.. it *probably* worked, but is just taking a while
              # Do we mark this as updated??. Lets assume yes as I 
              # *think* thats going to cause less grief with people trying
              # to use notifications
              new_resource.updated_by_last_action(true)
            end
          end
        else
          # Its been requested that we fire and forget, so error on the
          # optimistic side and assume its going to work
          new_resource.updated_by_last_action(true)
        end
      else
        Chef::Log.error("Failed to add #{new_resource.name} to Zenoss")
      end
  else
    Chef::Log.debug("#{new_resource.name} already exists")
  end
end

action :delete do
  unless @device.nil?
    begin
    # figure out the hashcheck, which is for some reason
    # required to delete...
    hashcheck = @connection.json_request(
      'DeviceRouter', 'getDevices',
    )['hash']
    
    result = @connection.json_request(
      'DeviceRouter', 'removeDevices',
      [{:uids => [@device.uid],
        :hashcheck => hashcheck.to_s,
        :action =>"delete"
      }]
    )
    
    if result.has_key?("success") && result['success'] == true
      new_resource.updated_by_last_action(true)
    end
    rescue => e
      puts e
    end
  end

end

# Check the Zenoss Server to see the current state of the
# Device
def load_current_resource
  require 'zenoss_client'
  @connection = Zenoss.connect( api_url(), 
      @new_resource.api_user,  @new_resource.api_password)
  
  
  @device = get_device()

  
end
  
def api_url
  n = @new_resource
  url = "#{n.api_protocol}://#{n.api_host}:#{n.api_port}/zport/dmd"
end

def get_device
  device = nil
  devices = @connection.find_devices_by_name(@new_resource.name)
  if devices && devices.size > 0
    device = devices.first
  end
  return device
end


