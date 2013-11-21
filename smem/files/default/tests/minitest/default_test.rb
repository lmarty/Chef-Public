describe_recipe "cookbook-smem" do
  include ::MiniTest::Chef::Assertions
  include ::MiniTest::Chef::Context
  include ::MiniTest::Chef::Resources

  describe "package" do
    it "installs" do
      package("smem").must_be_installed
    end
  end
end
