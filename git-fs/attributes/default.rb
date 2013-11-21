default['git-fs']['repository'] = 'https://github.com/g2p/git-fs.git'
default['git-fs']['revision']   = 'master'
default['git-fs']['clone_path'] = "/opt/git-fs"
default['git-fs']['bin_path']   = "/usr/local/bin/git-fs"

# See https://github.com/g2p/git-fs#build-instructions
default['git-fs']['packages'] = case node[:platform]
when 'debian', 'ubuntu'
  %w{omake libfuse-dev camlidl libpcre-ocaml-dev libbatteries-ocaml-dev}
when 'centos', 'redhat', 'fedora', 'suse', 'amazon'
  %w{fuse-devel ocaml-pcre-devel ocaml-findlib-devel ocaml-camomile ocaml-camlidl ocaml-bisect ocaml-ounit ocaml-ocamldoc}
when 'arch'
  %w{omake ocamlfuse-cvs pcre-ocaml ocaml-batteries}
end