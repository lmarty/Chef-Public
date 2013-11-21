
describe_recipe 'phpbb_test::default' do

  describe 'files' do
    it "creates a directory" do
      directory("/var/www/phpbb1").must_exist.with(:owner, "www-data")
    end
  end

  describe 'packages' do
    it "installs php" do
      package("php5").must_be_installed
    end

    it "installs apache2" do
      package("apache2").must_be_installed
    end

    it "installs mysql-client" do
      package("mysql-client").must_be_installed
    end

    it "installs mysql-server" do
      package("mysql-server").must_be_installed
    end

    it "installs imagemagick" do
      package("imagemagick").must_be_installed
    end

    it "installs php5-gd" do
      package("php5-gd").must_be_installed
    end
  end

  describe 'phpbb3 app' do
    it "downloads the phpbb3 from remote" do
      file("/var/www/phpbb1/viewforum.php").must_exist
    end

    it "check the content of the virtual host file" do
      file('/etc/apache2/sites-enabled/phpbb1.conf').must_include("ServerName phpbb1.local")
    end
  end
end
