class Chef
  class Provider
    class RemoteS3File < Chef::Provider::RemoteFile
      def load_current_resource
        super
        %w{bucket object_name aws_access_key_id aws_secret_access_key}.map do |attribute|
          Chef::Application.fatal! "remote_s3_file: required attr: #{attribute} is nil", -92 if
            @new_resource.send(attribute.to_sym).nil?
        end

        @new_resource.source( LibSonian.signed_url(@new_resource.bucket,
                                                   @new_resource.object_name,
                                                   @new_resource.aws_access_key_id,
                                                   @new_resource.aws_secret_access_key)
                              )
      end
    end
  end

  class Resource
    class RemoteS3File < Chef::Resource::RemoteFile
      def provider
        Chef::Provider::RemoteS3File
      end

      def initialize(name, run_context=nil)
        super
        @resource_name = :remote_s3_file
        @cookbook = nil
        Chef::Log.info "remote_s3_file: initializing #{name}"
      end

      def bucket(args=nil)
        set_or_return(
                      :bucket,
                      args,
                      :kind_of => String
                      )
      end

      def object_name(args=nil)
        set_or_return(
                      :object_name,
                      args,
                      :kind_of => String
                      )
      end

      def aws_access_key_id(args=nil)
        set_or_return(
                      :aws_access_key_id,
                      args,
                      :kind_of => String
                      )
      end

      def aws_secret_access_key(args=nil)
        set_or_return(
                      :aws_secret_access_key,
                      args,
                      :kind_of => String
                      )
      end
    end
  end
end

Chef::Platform.platforms[:default].merge! :remote_s3_file => Chef::Provider::RemoteS3File
