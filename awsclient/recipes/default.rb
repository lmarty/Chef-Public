#
# Cookbook Name:: awsclient
#
include_recipe "aws"
include_recipe "apt"


#Install all depdencies for fog gems on ubuntu
package "libxml2-dev" do
  action :install
end

package "libxslt-dev" do
  action :install
end

#Install hte gem itself
execute "gem install fog" do
  not_if "gem list | grep 'fog'"
end

