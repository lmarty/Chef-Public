module Rayo
  %w(json uri net/http digest openssl open-uri).each{|lib| require lib}

  class << self

    def get_header(uri,header='x-amz-meta-sha256-hash', port=80)
      hash = `curl -Is #{uri} | grep "#{header}" | awk '{print $2}'`.chomp
      Chef::Log.info("[get_header('#{uri}')] => (#{hash})")
      return hash
    end

    def lastest_sha1(opts={})
      puts "[RAYO] getting sha1 from maven [#{opts[:url]}]"
      opts={
        :url => 'maven.voxeo.net'
      }.merge!(opts)
      {
        :node    =>Net::HTTP.start(opts[:url]).get("/nexus/content/repositories/snapshots//com/rayo/rayo-war/2.0-SNAPSHOT/rayo-war-2.0-SNAPSHOT.war.sha1").body,
        :gateway =>Net::HTTP.start(opts[:url]).get("/nexus/content/repositories/snapshots//com/rayo/rayo-gateway/2.0-SNAPSHOT/rayo-gateway-2.0-SNAPSHOT.war.sha1").body
      }
    end

    def sessions(opts={})
      opts={
        :gateway =>false,
        :host    =>"127.0.0.1"
      }.merge(opts)
      response = JSON.parse(jolokia :host=>opts[:host], :bean=> (opts[:gateway] ? "/rayo/jmx/read/com.rayo.gateway:Type=GatewayStatistics/ActiveCallsCount" : "/rayo/jmx/read/com.rayo:Type=Calls/ActiveCallsCount"))
      puts "[RAYO] sessions ====> #{response["value"]}"
      if response["value"]
        return response["value"]
      else
        return 0
      end
    rescue Timeout::Error, Errno::EHOSTDOWN, JSON::ParserError, Errno::ECONNREFUSED, NoMethodError  => e
      puts "[RAYO] session rescue ===> #{response}"
      puts "[RAYO] session rescue ===> #{e.backtrace.join("\n")}"
      return 0
    end

    def quiesced?(opts={})
      opts={
        :gateway=>false
      }.merge(opts)
      response = JSON.parse(jolokia :host=>opts[:host], :bean=>"/rayo/jmx/read/com.rayo#{'.gateway' if opts[:gateway]}:Type=Admin,name=Admin/QuiesceMode")
      response["value"]
    rescue Exception => e
      puts e
    end

    def quiesce(opts={})
      opts={
        :gateway=>false
      }.merge(opts)
      response = JSON.parse(jolokia :host=>opts[:host], :bean=>"/rayo/jmx/exec/com.rayo#{'.gateway' if opts[:gateway]}:Type=Admin,name=Admin/#{opts[:operation]=='enable' ? 'enableQuiesce' : 'disableQuiesce'}")
      response["status"]
    rescue Exception => e
      puts e
    end

    def in_routing(opts={})
      false # Not implemented
    end

    def sha1(path)
      begin
        d = OpenSSL::Digest::SHA1.new
        f = File.open(path, 'r')
        while data = f.read(4096) do
          d << data
        end
        d.digest.unpack('H*').first
      rescue Errno::ENOENT
        return nil
      end
    end

    def sha256(path)
      begin
        d = OpenSSL::Digest::SHA256.new
        f = File.open(path, 'r')
        while data = f.read(4096) do
          d << data
        end
        d.digest.unpack('H*').first
      rescue Errno::ENOENT
        return nil
      end
    end

    def download opts={}
      b = get_latest_build
      opts={
        :gateway =>  b[:gateway],
        :node    =>  b[:node],
        :ci      =>  'ci.voxeolabs.com',
        :target  =>  "/opt/voxeo/prism/apps",
      }.merge!(opts)

      case opts[:install]
      when 'node' then download_file :target => "#{opts[:target]}/rayo.war", :resource => opts[:node]
      when 'gateway' then download_file :target => "#{opts[:target]}/rayo_gateway.war", :resource => opts[:gateway]
      end
    end

    def get_build_server_json
      Net::HTTP.start("ci.voxeolabs.net"){ |http|
        http.get("/jenkins/job/Rayo/api/json").body
      }
    end

    def get_latest_build
      latest           = {}
      latest[:path]    = JSON.parse(get_build_server_json)["lastSuccessfulBuild"]["url"]
      latest[:build]   = "#{latest[:path]}".split("Rayo")[1].gsub("/","")
      latest[:node]    = "http://files.voxeolabs.net/rayo/rayo.b#{latest[:build]}.war"
      latest[:gateway] = "http://files.voxeolabs.net/rayo/rayo-gateway.b#{latest[:build]}.war"
      return latest
    end

    def download_file(opts={})
      url = URI.parse(opts[:resource])
      Net::HTTP.start(url.host) do |http|
        begin
          file = File.open(opts[:target], 'w+b')
          http.request_get(url.request_uri) do |response|
            response.read_body do |segment|
              file.write(segment)
            end
          end
        ensure
          file.close
        end
      end
    end

    def jolokia(opts={})
      attempts = 0
      opts={
        :host =>'127.0.0.1',
        :port => 8080
      }.merge!(opts)
      http = Net::HTTP.new(opts[:host],opts[:port])
      http.read_timeout = 2
      http.open_timeout = 2
      http.get(opts[:bean]).body
    end
  end
end
