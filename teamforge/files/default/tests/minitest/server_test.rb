require File.expand_path('../support/helpers', __FILE__)
 
describe 'teamforge::server' do
 
  include Helpers::Teamforge

  describe "packages" do
    %w{teamforge teamforge-app teamforge-etl teamforge-scm}.each do |p|
      it "installs the package %{p}" do
        package(p).must_be_installed
      end
    end
    it "does not install the system postgres" do
      package("postgresql").wont_be_installed
    end
  end
  
  describe "services" do
    %w{collabnet postgresql-9.0}.each do |s|
      it "runs #{s} as a daemon" do
        service(s).must_be_running
      end

      it "starts #{s} on system boot" do
        service(s).must_be_enabled
      end
    end
  end

  describe "users and groups" do
    it "creates a user called 'sf-admin' with the right UID" do
      user("sf-admin").must_exist.must_have(:uid, 5002)
    end
    it "creates a group called 'sf-admin' with the right GID" do
      group("sf-admin").must_exist.must_have(:gid, 5002)
    end
  end

  describe "links and files" do
    it "creates a symlink from /etc/sourceforge.properties" do
      # Yes, that extra slash is significant, because of what the TeamForge installer does
      link("/etc/sourceforge.properties").must_exist.with(:link_type, :symbolic).and(:to, "/opt/collabnet/teamforge//runtime/conf/sourceforge.properties")
      assert_symlinked_file "/etc/sourceforge.properties", "root", "root", 0644
    end
  end

end
