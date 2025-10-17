#!/bin/bash
# ==========================
# EC2 User Data: WordPress + Apache + PHP on Ubuntu 22.04
# ==========================

set -ex  # exit on errors, print commands


# Update system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Apache, PHP, MySQL client and required extensions
sudo apt-get install -y apache2 php libapache2-mod-php php-mysql unzip curl mysql-client

# Download and extract WordPress
cd /tmp
sudo curl -O https://wordpress.org/latest.tar.gz
sudo tar -xvzf latest.tar.gz

# Deploy to Apache root
sudo rm -rf /var/www/html/*
sudo mv /tmp/wordpress/* /var/www/html/

# Set permissions
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Configure wp-config.php
cd /var/www/html
sudo cp wp-config-sample.php wp-config.php

# --- Replace with your RDS values ---
DB_NAME="myappdb"
DB_USER="admin"
DB_PASSWORD="SuperSecretPassword123!"
DB_HOST="my-rds-db.c8btkn5ykabj.eu-west-2.rds.amazonaws.com"

sudo sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sudo sed -i "s/username_here/$DB_USER/" wp-config.php
sudo sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
sudo sed -i "s/localhost/$DB_HOST/" wp-config.php

# Enable Apache rewrite
sudo a2enmod rewrite

# Allow .htaccess overrides
sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Restart Apache
sudo systemctl restart apache2
sudo systemctl enable apache2
