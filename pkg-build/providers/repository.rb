
action :load do
  Dir.glob(::File.join(new_resource.package_store || node[:fpm_tng][:package_dir], '*.deb')).each do |d_path|
    repository_package d_path do
      repository new_resource.name
    end
  end
end
