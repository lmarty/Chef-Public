#
# Cookbook Name:: mplayer
# Attributes:: default
#
# Copyright 2012-2013, Escape Studios
#

default[:mplayer][:install_method] = :source
default[:mplayer][:prefix] = "/usr/local"
default[:mplayer][:svn_repository] = "svn://svn.mplayerhq.hu/mplayer/trunk"
default[:mplayer][:svn_revision] = "HEAD"
default[:mplayer][:compile_flags] = []