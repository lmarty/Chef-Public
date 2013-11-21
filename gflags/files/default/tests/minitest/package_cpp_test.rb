require File.expand_path('../support/helpers', __FILE__)

describe_recipe "gflags::package_cpp" do
  include Helpers::Gflags

  it "installs gflags C++ packages" do
    gflags_packages_cpp.each do |p|
      package(p).must_be_installed
    end
  end
end
