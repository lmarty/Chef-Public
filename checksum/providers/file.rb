version = Chef::Version.new(Chef::VERSION)
use_inline_resources if version.major >= 11

def whyrun_supported?
  true
end

use_inline_resources

def load_current_resource
  @path = new_resource.name
  @checksum = new_resource.checksum
  @algorithm = new_resource.algorithm
end

action :verify do

  algorithm = @algorithm.downcase

  begin

    case algorithm
    when "md5"
      require 'digest/md5'
      filesum = Digest::MD5.file(@path).hexdigest
    when "sha1"
      require 'digest/sha1'
      filesum = Digest::SHA1.file(@path).hexdigest
    else
      Chef::Log.warn "Only MD5 or SHA1 is supported, defaulting to SHA1"
      require 'digest/sha1'
      filesum = Digest::SHA1.file(@path).hexdigest
    end

    if @checksum == filesum
      Chef::Log.info "#{algorithm.upcase} checksum match"
    else
      Chef::Log.error "#{algorithm.upcase} checksum mismatch"
    end

  rescue Errno::ENOENT
    Chef::Log.error "#{@path} is not a valid file to checksum"
  end

end
