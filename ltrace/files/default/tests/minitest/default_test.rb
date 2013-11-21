describe_recipe "cookbook-ltrace" do
  include ::MiniTest::Chef::Assertions
  include ::MiniTest::Chef::Context
  include ::MiniTest::Chef::Resources

  describe "package" do
    it "installs" do
      package("ltrace").must_be_installed
    end
  end
end
