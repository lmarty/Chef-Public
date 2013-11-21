%w{ build-essential pkg-config libcurl4-openssl-dev libfuse-dev fuse-utils libfuse2 libxml2-dev mime-support }.each do |pkg|
  package pkg
end

# install fuse
remote_file "/tmp/fuse-#{ node[:fuse][:version] }.tar.gz" do
  source "http://downloads.sourceforge.net/project/fuse/fuse-2.X/#{ node[:fuse][:version] }/fuse-#{ node[:fuse][:version] }.tar.gz"
  mode 0644
  action :create_if_missing
end

bash "install fuse" do
  cwd "/tmp"
  code <<-EOH
  tar zxvf fuse-#{ node[:fuse][:version] }.tar.gz
  cd fuse-#{ node[:fuse][:version] }
  ./configure --prefix=/usr
  make
  sudo make install

  EOH

  not_if { File.exists?("/usr/bin/fusermount") }
end


# install s3fs-c
git "clone s3fs-c repository" do
  repository "git://github.com/tongwang/s3fs-c.git"
  revision "HEAD"
  destination "/tmp/s3fs-c"
  action :sync
end

bash "install s3fs-c" do
  cwd "/tmp"
  code <<-EOH
  cd s3fs-c
  ./configure --prefix=/usr
  make
  sudo make install
  sudo mkdir -p /mnt/#{ node[:s3][:bucket] }
  sudo bash -c 'export AWSACCESSKEYID=#{ node[:access_key] }; export AWSSECRETACCESSKEY=#{ node[:secret_key] }; s3fs #{ node[:s3][:bucket] } /mnt/#{ node[:s3][:bucket] } -o allow_other'
  EOH

  not_if { File.exists?("/usr/bin/s3fs") }
end


