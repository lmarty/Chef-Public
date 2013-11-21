require 'minitest/spec'

class PkgBuildSpec < MiniTest::Chef::Spec
  describe_recipe 'pkg-build::ruby' do
    let(:ruby_deb) do
      File.join(
        node[:fpm_tng][:package_dir],
        "#{
          [
            node[:pkg_build][:pkg_prefix],
            'ruby',
            node[:pkg_build][:ruby][:version],
            node[:pkg_build][:ruby][:patchlevel],
            node[:pkg_build][:ruby][:version],
            node[:pkg_build][:ruby][:patchlevel]
          ].compact.join('-')
        }.deb"
      )
    end

    it 'should create a custom ruby package' do
      file(ruby_deb).must_exist
    end

    it 'should install into defined path prefix' do
      %x{dpkg-deb -c #{ruby_deb}}.split("\n").detect{|full_line|
        next if full_line.start_with?('l') # ignore links
        line = full_line.scan(%r{ \./.*$}).flatten.first.sub(' .', '')
        !line.start_with?(node[:pkg_build][:ruby][:install_prefix]) &&
          !node[:pkg_build][:ruby][:install_prefix].start_with?(line)
      }.must_be_nil
    end
  end
end
