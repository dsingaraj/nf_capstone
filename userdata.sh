#! /bin/bash

### Setup Wordpress ###
# This script installs MariaDB, PHP, configures a WordPress database, downloads and configures WordPress and updates PHP version

sudo yum update -y

# Install MariaDB, PHP and necessary tools
sudo yum install -y httpd mariadb105-server php php-mysqlnd unzip

# Start Apache service and enable it on system startup
sudo systemctl start httpd
sudo systemctl enable httpd

# Start MariaDB service and enable it on system startup
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Create WordPress database, user, and grant privileges
sudo mysql -e "CREATE DATABASE wordpress;"
sudo mysql -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppassword';"
sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Download, unzip, and configure WordPress in the webroot
cd /var/www/html
sudo curl -LO https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo mv -f wordpress/* ./

# Copy the sample WordPress configuration file and update the database credentials
sudo cp wp-config-sample.php wp-config.php 
sudo sed -i 's/database_name_here/wordpress/' wp-config.php 
sudo sed -i 's/username_here/wpuser/' wp-config.php 
sudo sed -i 's/password_here/wppassword/' wp-config.php

# Enable PHP 8.0 and update the system | for me necassary; for you maybe not
sudo amazon-linux-extras enable php8.0
sudo yum update -y

# Restart Apache service to apply changes
sudo service httpd restart