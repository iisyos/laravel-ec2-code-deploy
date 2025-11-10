#!/bin/bash
# scripts/after_install.sh

echo "Setting up application..."


cd /var/www/html
chown -R apache:apache .
chmod -R 755 .

sudo -u apache php artisan config:cache
sudo -u apache php artisan route:cache
sudo -u apache php artisan view:cache

echo "Application setup completed"
