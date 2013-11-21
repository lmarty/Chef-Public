#
# Cookbook Name:: mplayer
# Library:: helpers
#
# Copyright 2012-2013, Escape Studios
#

module MPLAYER
	module Helpers
		#Returns an array of package names that will install MPLAYER on a node.
		#Package names returned are determined by the platform running this recipe.
		def mplayer_packages
			value_for_platform(
				[ "ubuntu" ] => { "default" => [ "mplayer" ] },
				"default" => [ "mplayer" ]
			)
		end
	end
end

class Chef::Recipe
	include MPLAYER::Helpers
end