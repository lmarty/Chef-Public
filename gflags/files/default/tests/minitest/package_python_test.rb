require File.expand_path('../support/helpers', __FILE__)

describe_recipe "gflags::package_python" do
  include Helpers::Gflags

  it "installs gflags Python packages" do
    gflags_packages_python.each do |p|
      package(p).must_be_installed
    end
  end
end
