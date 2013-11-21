include_recipe "build-essential"

case node.platform_family
when "debian"
  prereqs = %w(automake pkg-config zlib1g-dev libpcre3-dev liblzma-dev)
when "rhel", "fedora"
  prereqs = %w(automake pkgconfig zlib zlib-devel pcre pcre-devel xz xz-devel)
when "suse"
  prereqs = %w(automake pkg-config zlib zlib-devel pcre pcre-devel xz xz-devel)
else
  Chef::Log.warn "Don't know prereqs for #{node.platform_family}; proceeding anyway"
  prereqs = []
end
prereqs.each do |pkg|
  package pkg do
    action :install
  end
end

cache = "the_silver_searcher-#{node.the_silver_searcher.version}"

remote_file "#{Chef::Config['file_cache_path']}/#{cache}.tar.gz" do
  source "https://github.com/ggreer/the_silver_searcher/archive/#{node.the_silver_searcher.version}.tar.gz"
  checksum node.the_silver_searcher.checksum
  notifies :run, "bash[install the_silver_searcher]", :immediately
end

bash "install the_silver_searcher" do
  user "root"
  cwd Chef::Config['file_cache_path']
  code <<-EOH
      tar -zxf #{cache}.tar.gz
      (cd #{cache} && ./build.sh && make install)
    EOH
  action :nothing
end
