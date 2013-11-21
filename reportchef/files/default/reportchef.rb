require 'net/http'
require 'uri'

class ReportChef < Chef::Handler
  def initialize(opts = nil)
    @opts = opts
  end

  def report
    params = @opts.merge({ :node_name => run_status.node.fqdn })

    if run_status.failed?
      params[:last_run_successful] = false
      params[:exception] = run_status.formatted_exception
      params[:backtrace] = run_status.backtrace.join("\n")
    else
      params[:last_run_successful] = true
    end

    uri = URI.parse("http://reportchef.com/api/v1/reports")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)
    response = http.request(request)
  end
end
