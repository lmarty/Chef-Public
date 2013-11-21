require 'minitest/spec'

describe_recipe 'peceptive_content_bridge::default' do

  it "creates a user named pepUser" do
    user("pepUser").must_exist
  end

end
