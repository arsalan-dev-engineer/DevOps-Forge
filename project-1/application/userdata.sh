#!/bin/bash
set -ex

# Update system
apt-get update -y
apt-get upgrade -y

# Install Apache, PHP, MySQL client, AWS CLI dependencies
apt-get install -y apache2 php libapache2-mod-php php-mysql unzip curl mysql-client jq

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip /tmp/awscliv2.zip -d /tmp
/tmp/aws/install

# Download and extract WordPress
cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz

# Deploy to Apache root
rm -rf /var/www/html/*
mv /tmp/wordpress/* /var/www/html/

# Set permissions
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Configure wp-config.php
cd /var/www/html
cp wp-config-sample.php wp-config.php

# Database configuration
DB_NAME="myappdb"
DB_USER="admin"
DB_HOST="my-rds-db.c8btkn5ykabj.eu-west-2.rds.amazonaws.com"

# Fetch password securely from SSM Parameter Store
DB_PASSWORD=$(aws ssm get-parameter \
  --name "/wordpress/db/password" \
  --with-decryption \
  --region eu-west-2 \
  --query "Parameter.Value" \
  --output text)

# Inject DB settings into wp-config.php
sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/" wp-config.php
sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
sed -i "s/localhost/$DB_HOST/" wp-config.php

# Enable Apache rewrite
a2enmod rewrite
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Restart Apache
systemctl restart apache2
systemctl enable apache2
