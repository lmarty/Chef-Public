describe_recipe "cookbook-iperf" do
  include ::MiniTest::Chef::Assertions
  include ::MiniTest::Chef::Context
  include ::MiniTest::Chef::Resources

  describe "package" do
    it "installs" do
      package("iperf").must_be_installed
    end
  end
end
