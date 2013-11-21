require 'minitest/spec'

class PkgBuildSpec < MiniTest::Chef::Spec
  describe_recipe 'pkg-build::passenger' do
    let(:passenger_gem_deb) do
      File.join(
        node[:fpm_tng][:package_dir],
        "#{
          [
            node[:pkg_build][:pkg_prefix],
            'rubygem-passenger',
            node[:pkg_build][:passenger][:version]
          ].compact.join('-')
        }.deb"
      )
    end

    let(:passenger_mod_deb) do
      File.join(
        node[:fpm_tng][:package_dir],
        "#{
          [
            node[:pkg_build][:pkg_prefix],
            'libapache2-mod-passenger',
            node[:pkg_build][:passenger][:version]
          ].compact.join('-')
        }.deb"
      )
    end

    let(:gems_dir) do
      @d ||= node[:languages][:ruby][:gems_dir]
    end

    let(:passenger_root) do
      @p ||= File.dirname(node[:languages][:ruby][:bin_dir])
    end

    let(:ruby_bin_dir) do
      @r ||= node[:languages][:ruby][:bin_dir]
    end

    let(:apache_conf_dir){ '/etc/apache2' }

    it 'should create a custom passenger rubygem package' do
      file(passenger_gem_deb).must_exist
    end
    
    it 'should create a custom passenger apache2 module package' do
      file(passenger_mod_deb).must_exist
    end

    it 'should install module into ruby detected defined prefix and apache configurations into /etc/apache2' do
      %x{dpkg-deb -c #{passenger_mod_deb}}.split("\n").delete_if{|full_line|
        line = full_line.scan(%r{ \./.*$}).flatten.first.sub(' .', '')
        full_line.start_with?('l') ||
        line.start_with?(passenger_root) ||
        passenger_root.start_with?(line) ||
        line.start_with?(apache_conf_dir) ||
        apache_conf_dir.start_with?(line)
      }.must_be_empty
    end

    it 'should install passenger gem into "system" gem directory' do
      %x{dpkg-deb -c #{passenger_gem_deb}}.split("\n").delete_if{|full_line|
        line = full_line.scan(%r{ \./.*$}).flatten.first.sub(' .', '')
        full_line.start_with?('l') ||
        line.start_with?(gems_dir) ||
        gems_dir.start_with?(line) ||
        line.start_with?(ruby_bin_dir) ||
        ruby_bin_dir.start_with?(line)
      }.must_be_empty
    end

    it 'should have created modules in the apache2 module package' do
      %x{dpkg-deb -c #{passenger_mod_deb}}.split("\n").detect{|line|
        line.end_with?('.so')
      }.wont_be_nil
    end

  end
end
