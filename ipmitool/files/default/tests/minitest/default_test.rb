describe_recipe "cookbook-ipmitool" do
  include ::MiniTest::Chef::Assertions
  include ::MiniTest::Chef::Context
  include ::MiniTest::Chef::Resources

  describe "package" do
    it "installs" do
      package("ipmitool").must_be_installed
    end
  end

  describe "services" do
    ##
    # Tough to test this on a Virtual Machine.
    # Service will fail to start due to missing device.

    ipmi_device = ::File.join ::File::SEPARATOR, "dev", "ipmi0"
    if ::File.exists? ipmi_device
      it "runs as a daemon" do
        service("ipmievd").must_be_running
      end
    end

    it "boots on startup" do
      service("ipmievd").must_be_enabled
    end
  end
end
