#
# Cookbook Name:: repos
# Recipe:: default
#

node['repos'].each do |repo|
  if repo.is_a?(String) then
    include_recipe "repos::#{repo}"
  else
    case repo["type"]
    when "apt" then
      apt_repository repo["name"] do
        %w{uri distribution components arch deb_src
           keyserver key cookbook cache_rebuild}.each do |attr|
          send(attr, repo[attr])  if repo[attr]
        end
      end
    end
  end
end
