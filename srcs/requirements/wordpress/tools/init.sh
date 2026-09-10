#!/bin/bash
set -e

#web directory
mkdir -p /var/www/html
chown -R www-data:www-data /var/www/html

cd /var/www/html

# 1. Download WordPress 
if [ ! -f "wp-login.php" ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
fi

# 2. Configure and install WordPress
if [ ! -f "wp-config.php" ]; then
    echo "Configuring WordPress..."
    
    # Create wp-config.php
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="mariadb" \
        --allow-root

    # Install WordPress and set up the Admin user
    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception Project" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    # Create the secondary standard user
    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=author \
        --allow-root
        
    echo "WordPress installation complete!"
fi

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F