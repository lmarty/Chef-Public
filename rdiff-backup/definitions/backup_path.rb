#
# Cookbook Name:: rdiff-backup
# Definition:: backup_path
#
# Copyright 2013, Piratenfraktion NRW
#

define :backup_path, :weight => "0" do
  node.set['rdiff-backup']['include'][params[:name]] = params[:weight]
end
