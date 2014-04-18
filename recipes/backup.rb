#
# Cookbook Name:: wordpress
# Recipe:: backup
#
# Copyright 2014, KMI Learning
#
#This recipe creates a backup and restore script based on node wordpress attributes. 
#Backup happens at 1am everyday. 7 days of backups are kept. Edit template to customize.

#Create new backup directory
directory "/var/www/wordpress-backups" do
  action :create
  owner "root"
  group "root"
end

#Create cron job to backup wordpress DB and files Daily
cron "backup-wordpress" do
  user "root"
  minute "0"
  hour "1"
  command 'cd /var/www/wordpress-backups/ && ./backup.sh'
end

#Build backup script from template
template "/var/www/wordpress-backups/backup.sh" do
  variables(:db_database => node['wordpress']['db']['database'],
            :db_user => node['wordpress']['db']['user'],
            :db_pass => node['wordpress']['db']['password'],
            :wp_dir => node['wordpress']['dir'])
  source "backup.sh.erb"
  owner "root"
  group "root"
  mode "700"
end

#build restore script from template
template "/var/www/wordpress-backups/restore.sh" do
  variables(:db_database => node['wordpress']['db']['database'],
            :db_user => node['wordpress']['db']['user'],
            :db_pass => node['wordpress']['db']['password'],
            :wp_dir => node['wordpress']['dir'])
  source "restore.sh.erb"
  owner "root"
  group "root"
  mode "700"
end
