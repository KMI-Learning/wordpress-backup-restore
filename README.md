wordpress-backup-restore
========================

This is a recipe to add to the Opscode Chef Wordpress cookbook. 
It will create a backup and restore script based on your node's Wordpress attributes.
Backups will happen nightly at 1am and be kept for 7 days. Restores can be applied anytime manually.

To Use
======
Copy these files to the wordpress cookbook.
Simply add include_recipe "wordpress::backup" in the default recipe or add wordpress::backup to the node run list.


