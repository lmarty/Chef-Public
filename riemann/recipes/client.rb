#
# Cookbook Name:: riemann
# Recipe:: client
#
#


script "compile_ruby" do
  interpreter "bash"
  user "root"
  cwd "/tmp/"
  creates "/usr/local/bin/gem"
  code <<-EOH
  STATUS=0
  wget #{node[:riemann][:ruby_tarball_location]} || STATUS=1
  tar xvzf #{node[:riemann][:ruby_tarball]} || STATUS=1
  cd #{node[:riemann][:ruby_tarball_dir]} || STATUS=1
  ./configure --prefix=/usr/local/ --enable-shared --disable-install-doc|| STATUS=1
  make|| STATUS=1
  make install|| STATUS=1
  cd /tmp/|| STATUS=1
  rm -rf #{node[:riemann][:ruby_tarball]}*|| STATUS=1
  exit $STATUS
  EOH
end



%w{riemann-client riemann-tools}.each do |pkg|
  gem_package pkg do
    action [:install]
  end
end
