#! /bin/bash
sudo yum update -y
sudo yum install -y httpd php 
sudo yum install -y php-mysqli
sudo systemctl enable httpd
sudo systemctl start httpd

cd /var/www/html
aws s3 sync s3://deham6-wordpress/ .

sudo sed -i "s/database_name_here/${DB}/" wp-config.php
sudo sed -i "s/username_here/${User}/" wp-config.php
sudo sed -i "s/password_here/${PW}/" wp-config.php
sudo sed -i "s/localhost/${host}/" wp-config.php

sudo service httpd restart