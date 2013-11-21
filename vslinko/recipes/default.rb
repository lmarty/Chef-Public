include_recipe "git"
include_recipe "sudo"
include_recipe "zsh"

group node["vslinko"]["group"]

user node["vslinko"]["user"] do
  comment "Vyacheslav Slinko"
  gid node["vslinko"]["group"]
  home node["vslinko"]["home"]
  shell "/bin/zsh"
  supports :manage_home => true
end

sudo node["vslinko"]["user"] do
  user node["vslinko"]["user"]
  nopasswd true
end

directory "#{node["vslinko"]["home"]}/.ssh" do
  group node["vslinko"]["group"]
  mode 0700
  owner node["vslinko"]["user"]
end

file "#{node["vslinko"]["home"]}/.ssh/authorized_keys" do
  content node["vslinko"]["public_key"]
  group node["vslinko"]["group"]
  mode 0600
  owner node["vslinko"]["user"]
end

include_recipe "vslinko::dotfiles"
