describe_recipe "cookbook-iotop" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "package" do
    it "installs iotop" do
      package("iotop").must_be_installed
    end
  end
end
