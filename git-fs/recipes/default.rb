#
# Cookbook Name:: git-fs
# Recipe:: default
#
# Copyright (C) 2013 Andrew Fecheyr
#

# Install Build dependencies
node['git-fs']['packages'].each do |pkg|
  package pkg
end

# Clone the git-fs repository
git "git-fs" do
  repository        node['git-fs']['repository']
  revision          node['git-fs']['revision']
  destination       node['git-fs']['clone_path']
  enable_submodules true
  action            :sync
  notifies          :run, "bash[compile-git-fs]", :immediate
end

# Compile the code
bash "compile-git-fs" do
  cwd       node['git-fs']['clone_path']
  code      <<-EOS
            make -C deps/ocamlfuse/lib || make -C deps/ocamlfuse/lib byte-code-library
            omake
            EOS
  action    :nothing
end

# Link the binary to /usr/local/bin
link "git-fs" do
  target_file node['git-fs']['bin_path']
  to File.join(node['git-fs']['clone_path'], 'git-fs')
end
