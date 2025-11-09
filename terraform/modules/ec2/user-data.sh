#!/bin/bash
echo "### (AL2023) OS update"

set -euxo pipefail

dnf -y update
dnf -y install httpd php php-fpm

cat > /etc/httpd/conf.d/99-php-fpm-userdata.conf <<'EOF'
<Directory "/var/www/html">
    AllowOverride All
</Directory>

<FilesMatch "\.php$">
    SetHandler "proxy:unix:/var/run/php-fpm/www.sock|fcgi://localhost/"
</FilesMatch>
EOF

systemctl enable --now php-fpm
systemctl enable --now httpd
