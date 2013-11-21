case node['gflags']['install_type']
when "archive"
  include_recipe "gflags::archive"
when "package"
  include_recipe "gflags::package_cpp"
else
  gflags_recipe = value_for_platform(
    %w{centos fedora redhat} => {
      "default" => "package_cpp"
    },
    %w{ubuntu} => {
      "12.04" => "archive",
      "default" => "package_cpp"
    }
  )

  include_recipe "gflags::#{gflags_recipe}"
end
