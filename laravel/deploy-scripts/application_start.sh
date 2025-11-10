#!/bin/bash
# scripts/application_start.sh

echo "Starting application..."

sudo -u apache php artisan migrate --force

systemctl restart php-fpm

echo "Application started successfully"
