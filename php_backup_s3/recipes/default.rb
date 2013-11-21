#
# Cookbook Name:: php_backup_s3
# Recipe:: default
#
# Copyright (C) 2013 Ian Neubert
# 
# MIT license
#
frequencies = %w(weekly daily hourly)

Chef::Application.fatal!("node[\"php_backup_s3\"][\"frequency\"] must be set to one of: #{frequencies}") unless frequencies.include?(node["php_backup_s3"]["frequency"])

git "/opt/php_backup_s3" do
  repository "https://github.com/ianneub/php_backup_s3.git"
  revision "master"

  user "root"
  group "root"

  action :sync
end

template "/opt/php_backup_s3/backup.php" do
  action :create

  mode 0600
  user "root"
  group "root"

  variables(
    :s3_bucket => node["php_backup_s3"]["s3_bucket"],
    :aws_access_key => node["php_backup_s3"]["aws_access_key"],
    :aws_secret_key => node["php_backup_s3"]["aws_secret_key"],
    :frequency => node["php_backup_s3"]["frequency"]
  )
end

cron "php_backup_s3" do
  action :create
  command "/usr/bin/php /opt/php_backup_s3/backup.php"

  case node["php_backup_s3"]["frequency"]
  when "weekly"
    hour node["php_backup_s3"]["cron"]["hour"]
    weekday node["php_backup_s3"]["cron"]["weekday"]
  when "daily"
    hour node["php_backup_s3"]["cron"]["hour"]
  end

  minute node["php_backup_s3"]["cron"]["minute"]

  user "root"
end
