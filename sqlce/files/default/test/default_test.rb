require 'minitest/spec'

describe_recipe 'default::test' do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources
  
  describe "files" do
    it "installed the sqlce 4.0 sp1 package" do
      file("C:\\Program Files\\Microsoft SQL Server Compact Edition\\v4.0\\sqlcecompact40.dll").must_exist
    end
  end
  
 end