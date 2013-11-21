php_backup_s3 "my_backup" do
  
  backup_files %w(/etc /root)
  # backup_files_prefix "asdf"

  databases = []
  databases << {
    "hostname" => "host",
    "username" => "user",
    "password" => "pass",
    # "prefix" => "asdf",
    "query" => "SELECT * WHERE 1 = 1"
  }
  backup_dbs databases

end
