#
# Cookbook Name:: gpac
# Library:: helpers
#
# Copyright 2012-2013, Escape Studios
#

module GPAC
	module Helpers
		#Returns an array of package names that will install GPAC on a node.
		#Package names returned are determined by the platform running this recipe.
		def gpac_packages
			value_for_platform(
				[ "ubuntu" ] => { "default" => [ "gpac" ] },
				"default" => [ "gpac" ]
			)
		end
	end
end

class Chef::Recipe
	include GPAC::Helpers
end