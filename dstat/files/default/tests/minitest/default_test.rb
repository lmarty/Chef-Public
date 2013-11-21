describe_recipe "cookbook-dstat" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context 
  include MiniTest::Chef::Resources

  describe "package" do
    it "installs dstat" do
      package("dstat").must_be_installed
    end
  end
end
