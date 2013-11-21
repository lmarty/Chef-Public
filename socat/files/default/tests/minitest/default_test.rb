describe_recipe "cookbook-socat" do
  include ::MiniTest::Chef::Assertions
  include ::MiniTest::Chef::Context
  include ::MiniTest::Chef::Resources

  describe "package" do
    it "installs" do
      package("socat").must_be_installed
    end
  end
end
