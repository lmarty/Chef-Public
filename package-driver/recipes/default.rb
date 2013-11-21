# Author:: Mark Hibberd <mark@hibber.id.au>
# Cookbook Name:: package-driver
# Recipe:: default

bag = node['package-driver']['data_bag']
ref = node['package-driver']['items']
items = node[ref]

items.each do |i|
  item = data_bag_item(bag, i)
  packages = item['packages']

  packages.each do |pkg|
    package(pkg) do
      action :install
    end
  end
end
