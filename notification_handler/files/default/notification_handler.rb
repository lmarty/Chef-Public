require 'net/http'
require 'uri'
require 'rest_client'

class NotificationHandler < Chef::Handler
  def initialize(opts = nil)
    @opts = opts
  end

  def report
    params = Hash.new
	params[:node_name] = node["notification_handler"]["instanceId"]

    if run_status.failed?
      params[:last_run_successful] = false
      params[:exception] = run_status.formatted_exception
      params[:backtrace] = run_status.backtrace.join("\n")
    else
      params[:last_run_successful] = true
    end
	
	arr = Array.new
	IO.foreach(File.expand_path(Chef::Config[:log_location])) { |line| 
		arr << line 
		}
		
    status = run_status.success?
    attribs = (node.normal_attrs).to_hash
	attribs.delete("notification_handler")
	attribs.delete("chef_handler")
    host = node["notification_handler"]["chefCallbackEndpoint"]["host"]
    port = node["notification_handler"]["chefCallbackEndpoint"]["port"]
    path = node["notification_handler"]["chefCallbackEndpoint"]["path"] 
	
	if node["notification_handler"]["metadata"] == nil
		instance_metadata = Hash.new
	else	
		instance_metadata = node["notification_handler"]["metadata"].to_hash
	end
	
	instance_metadata["chef"] = {
		"log_location" => File.expand_path(Chef::Config[:log_location]),
		"attributes" => attribs
		}
    if status == true
       chefrun = "completed"
    else
       chefrun = "failed"
    end

    RestClient.post(
  		"http://#{host}:#{port}#{path}",
		{
		:results => {
			:requestStatus => chefrun
			},
		  :callbackEndpoint => {
			:host => node["notification_handler"]["callbackEndpoint"]["host"],
			:port => node["notification_handler"]["callbackEndpoint"]["port"],
			:path => node["notification_handler"]["callbackEndpoint"]["path"]
			},
		  :requestId => node["notification_handler"]["requestId"],
		  :instanceId => node["notification_handler"]["instanceId"],
		  :auth => node["notification_handler"]["auth"],
		  :metadata => instance_metadata
		  })  		  
  end
end
