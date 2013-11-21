#
# Cookbook Name:: fping
# Recipe:: default
#

include_recipe 'yum::repoforge' if platform_family?('rhel')

package 'fping'
