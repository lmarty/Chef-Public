if(node[:pkg_build][:reprepro])
  template '/usr/local/bin/pkg-build-remover' do
    source 'pkg-build-remover.erb'
    mode 0755
  end
end
