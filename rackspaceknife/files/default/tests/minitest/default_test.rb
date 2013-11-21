require 'minitest/spec'

describe 'rackspaceknife::default' do
  # Include requireed MiniTest classes.
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources

    # Test if Perl binary exists. Root should own Perl binary
    it "does_perl_binary_exist" do
      file("#{node.set['rackspaceknife']['which_perl']}").must_have(:mode, "755").with(:owner, "root").and(:group, "root")
    end

    # Test can we execute Perl.
    it "can_we_execute_perl" do
      assert system('perl --version |grep Copyright')
    end

    # Test if rackspaceknife.pl exists. Root should own rackspaceknife.pl.
    it "does_rackspaceknife_binary_exist" do
      file("/usr/local/bin/rackspaceknife.pl").must_have(:mode, "755").with(:owner, "root").and(:group, "root")
    end

    # Test if WebService::Rackspace::CloudFiles exists.
    #it "does_CloudFiles.pm_exist" do
    #  assert system('updatedb; locate CloudFiles.pm |grep CloudFiles.pm')
    #end

    # Test if Perl module directory exists.
    it "does_perl_module_dir_exist" do
      directory("#{node.set['rackspaceknife']['perl_modules_dir']}").must_have(:mode, "755").with(:owner, "root").and(:group, "root")
    end

    # Test can we execute rackspaceknife.pl.
    it "can_we_execute_rackspaceknife" do
      assert system('rackspaceknife.pl --help |grep Usage')
    end 

end
