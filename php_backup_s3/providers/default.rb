def whyrun_supported?
  true
end

action :create do

  # create the backup template file
  template "/opt/php_backup_s3/backups/#{new_resource.name}.php" do
    action :create
    
    cookbook "php_backup_s3"
    source "backup_resource.php.erb"

    owner "root"
    group "root"
    mode 0600

    variables(
      :backup_files => new_resource.backup_files,
      :backup_files_prefix => new_resource.backup_files_prefix,
      :backup_dbs => new_resource.backup_dbs
    )
  end

end

action :delete do

  # delete the backup template file
  template "/opt/php_backup_s3/backups/#{new_resource.name}.php" do
    action :delete

    cookbook "php_backup_s3"
    source "backup_resource.php.erb"
  end

end
