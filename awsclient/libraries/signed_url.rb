module LibSonian
  def self.signed_url(bucket,
                      object_name,
                      aws_access_key_id,
                      aws_secret_access_key)
    begin
      Gem.clear_paths
      require 'fog'
    rescue LoadError
      Chef::Log.warn("Missing gem 'fog'")
    end

    @@s3 ||= ::Fog::AWS::Storage.new(:aws_access_key_id => aws_access_key_id,
                                     :aws_secret_access_key => aws_secret_access_key)
    url = @@s3.directories.get(bucket).files.get_url(object_name, Time.now + (60 * 10))
    Chef::Log.info "signed_url[#{bucket}/#{object_name}]: generated signed 10 minute S3 url #{url}"
    url
  end
end
