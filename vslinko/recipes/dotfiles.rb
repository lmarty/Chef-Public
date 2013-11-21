execute "#{node["vslinko"]["user"]}_dotfiles" do
  command <<-EOC
    git init
    git remote add origin #{node["vslinko"]["dotfiles"]}
    git pull -u origin master
    git submodule update --init
  EOC
  creates "#{node["vslinko"]["home"]}/.git"
  cwd node["vslinko"]["home"]
  group node["vslinko"]["group"]
  user node["vslinko"]["user"]
end

git node["vslinko"]["home"] do
  group node["vslinko"]["group"]
  repository node["vslinko"]["dotfiles"]
  user node["vslinko"]["user"]
  enable_submodules true
  action :sync
end
