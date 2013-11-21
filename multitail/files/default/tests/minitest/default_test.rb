require File.expand_path 'support/test_helpers', File.dirname( __FILE__ )


describe_recipe "multitail:default" do
	include Minitest::TestHelpers

	describe "packages" do
		%w( multitail ).each do |p|
			it "has the #{p} package installed" do
				package( p ).must_be_installed
			end
		end
	end

	describe 'bin on path' do
		%w( multitail ).each do |b|
			it "has #{b} on the PATH" do
				bin_on_path b
			end
		end
	end


	describe 'files' do
		it "has a multitail.conf file" do
				file( node['multitail']['conf_dir'] ).must_exist
			end
		end
	end
end