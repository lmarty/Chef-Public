module PkgBuild
  module Ruby
    class << self
      def ruby_name(node, version)
        name = [node[:pkg_build][:pkg_prefix]]
        name << 'ruby'
        if(node[:pkg_build][:ruby][:suffix_version])
          name << version
        end
        name.compact.join('-')
      end

      def gem_name(node, name, ruby_version=nil)
        gname = []
        gname << node[:pkg_build][:pkg_prefix]
        gname << 'rubygem'
        gname << ruby_version if ruby_version
        gname << name
        gname.compact.join('-')
      end

      def ruby_build(node, version, patchlevel)
        patch = patchlevel.to_s.start_with?('p') ? patchlevel : "p#{patchlevel}"
        "#{ruby_name(node, version)}-#{version}-#{patch}"
      end
    end
  end
end
