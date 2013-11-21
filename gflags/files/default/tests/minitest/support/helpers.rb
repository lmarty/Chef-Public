module Helpers
  module Gflags
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources

    def gflags_packages_cpp
      case node['platform']
      when "centos", "fedora", "redhat"
        %w{gflags gflags-devel}
      when "ubuntu"
        %w{libgflags2 libgflags-dev}
      end
    end

    def gflags_packages_python
      case node['platform']
      when "centos", "fedora", "redhat"
        %w{gflags-python}
      when "ubuntu"
        %w{python-gflags}
      end
    end
  end
end
