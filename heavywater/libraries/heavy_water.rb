module HeavyWater
  def auth_s3_url( hash )
    seconds_to_expire = hash[:seconds_to_expire] ||= 60
    s3 = Fog::Storage.new( :provider => "aws",
                           :aws_access_key_id => hash[:aws_access_key_id],
                           :aws_secret_access_key => hash[:aws_secret_access_key] )
    bucket = s3.directories.get( hash[:bucket] )
    file = bucket.files.get( hash[:object] )
    file.url( seconds_to_expire + Time.now.to_i )
  end
end
