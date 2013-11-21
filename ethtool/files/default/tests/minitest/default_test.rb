describe_recipe "cookbook-ethtool" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "package" do
    it "installs ethtool" do
      package("ethtool").must_be_installed
    end
  end
end
