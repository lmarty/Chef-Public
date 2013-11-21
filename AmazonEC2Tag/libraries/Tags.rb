require 'rubygems'
require 'yaml'
require 'aws-sdk'

module ChefAmazon
  module Ec2
    class Tags
      def Tags.putTag(accessKey,secretKey,tag,value,id)
        ec2 = AWS::EC2.new(:access_key_id => accessKey,
          :secret_access_key => secretKey)
        ec2Instance=ec2.instances[id];
        ec2Instance.add_tag(tag,{:value=>value})
      end
    end
  end
end