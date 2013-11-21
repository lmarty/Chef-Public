describe_recipe "cookbook-tree" do
  include ::MiniTest::Chef::Assertions
  include ::MiniTest::Chef::Context
  include ::MiniTest::Chef::Resources

  describe "package" do
    it "installs" do
      package("tree").must_be_installed
    end
  end
end
