#
# Cookbook Name:: cookbook-ajenti
# Recipe:: centos
#
# Copyright 2013, Egor Medvedev

include_recipe "yum"

yum_repository "ajenti" do
  name "Ajenti"
  url "http://repo.ajenti.org/centos/"
  action :add
end

package "ajenti"