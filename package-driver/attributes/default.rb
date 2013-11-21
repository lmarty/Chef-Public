# Author:: Mark Hibberd <mark@hibberd.id.au>
# Cookbook Name:: package-driver
# Attributes:: default

#-- specify the name of the data bag to look for package sets in
default['package-driver']['data_bag'] = 'packages'

#-- specify the name of the attribute that contains the names of
#   the data bag items to process as a package set.
default['package-driver']['items'] = 'packages'
