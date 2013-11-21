describe_recipe "cookbook-mtr" do
  include ::MiniTest::Chef::Assertions
  include ::MiniTest::Chef::Context
  include ::MiniTest::Chef::Resources

  describe "package" do
    it "installs" do
      package("mtr").must_be_installed
    end
  end
end
