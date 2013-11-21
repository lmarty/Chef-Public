include ChefAmazon

action :create do
  ChefAmazon::Ec2::Tags.putTag(new_resource.aws_access_key, new_resource.aws_secret_access_key,new_resource.tag,new_resource.value,new_resource.instance_id)
end