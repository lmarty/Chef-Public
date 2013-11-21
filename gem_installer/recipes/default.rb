# Iterate and install gems
[[node[:gem_installer][:gems], :gem_package], [node[:gem_installer][:chef_gems], :chef_gem]].each do |items, pkg_method|
  items.each_pair do |gem, gem_version|
    send(pkg_method, gem) do
      version gem_version if gem_version
    end
  end
end
