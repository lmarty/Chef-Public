#
# Cookbook Name:: gpac
# Attributes:: default
#
# Copyright 2012-2013, Escape Studios
#

default[:gpac][:install_method] = :source
default[:gpac][:prefix] = "/usr/local"
default[:gpac][:svn_repository] = "svn://svn.code.sf.net/p/gpac/code/trunk/gpac"
default[:gpac][:svn_revision] = "HEAD"
default[:gpac][:compile_flags] = []

case node[:platform]
	when "debian", "ubuntu"
		default[:gpac][:dependencies] = [
			"zlib1g-dev",
			"xulrunner-1.9.2-dev",
			"libfreetype6-dev",
			"libjpeg62-dev",
			"libpng12-dev",
			"libopenjpeg-dev",
			"libmad0-dev",
			"libfaad-dev",
			"libogg-dev",
			"libvorbis-dev",
			"libtheora-dev",
			"liba52-0.7.4-dev",
			"libavcodec-dev",
			"libavformat-dev",
			"libavutil-dev",
			"libswscale-dev",
			"libxv-dev",
			"x11proto-video-dev",
			"libgl1-mesa-dev",
			"x11proto-gl-dev",
			"linux-sound-base",
			"libxvidcore-dev",
			"libwxbase2.8-dev",
			"libwxgtk2.8-dev",
			"wx2.8-headers",
			"libssl-dev",
			"libjack-dev",
			"libasound2-dev",
			"libpulse-dev",
			"libsdl1.2-dev",
			"dvb-apps"		
		]
	else
		default[:gpac][:dependencies] = []		
end