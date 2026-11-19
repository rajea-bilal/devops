#!/bin/bash
set -euo pipefail

# apt is intended for terminal use
# ap-get is used for scripts

apt-get update 
apt-get install -y nginx

# php-fmp package receives php work from nginx, executes php code and returns nginx the result
apt-get install -y php-fpm 


# install mysql-server - a database service to create databases inside
# php8.3-mysql extnesion allows wordpress to communicate with mysql db
# curl allows us to download wordpress software from a url 
apt-get install -y mysql-server php8.3-mysql curl 

# generate a random password
db_password="$(openssl rand -hex 24)"

# create db inside mySQL DB service
# create a db login (wordpress_user) that wp can use to access db
# grant priviledges to that db login to read/write data to the db

mysql -u root <<SQL
CREATE DATABASE MySQL_DB CHARACTER SET utf8mb4;
CREATE USER 'wordpress_user'@'localhost' IDENTIFIED BY '${db_password}';
GRANT ALL PRIVILEGES ON \`MySQL\_DB\`.* TO 'wordpress_user'@'localhost';
SQL

# download and unpack wordpress
mkdir -p /var/www/wordpress
curl -fsSL https://wordpress.org/latest.tar.gz -o /tmp/wordpress.tar.gz # download
tar -xzf /tmp/wordpress.tar.gz --strip-components=1 -C /var/www/wordpress # unpack

# give wp database login created
wp_salts="$(curl -fsSL https://api.wordpress.org/secret-key/1.1/salt/)"

cat > /var/www/wordpress/wp-config.php <<PHP
<?php
define('DB_NAME', 'MySQL_DB');
define('DB_USER', 'wordpress_user');
define('DB_PASSWORD', '${db_password}');
define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

${wp_salts}

\$table_prefix = 'wp_';

define('ABSPATH', __DIR__ . '/');
require_once ABSPATH . 'wp-settings.php';
PHP

# chown - who owns the file, sets the file owner to root, group to www-data
chown root:www-data /var/www/wordpress/wp-config.php

# chmod - what each user can do
# what each group can do 
# 6 - root - read & write
# 4 - group (www-data) - read only
# 0 - other users - no access
chmod 640 /var/www/wordpress/wp-config.php

# Tell Nginx where WordPress lives and where to send PHP requests.
# http on port 80
# wordpress website files folder
#  / url leads to index.php
cat > /etc/nginx/sites-available/default <<'NGINX'
server {
    listen 80 default_server; 
    root /var/www/wordpress;
    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock;
    }
}
NGINX

systemctl restart php8.3-fpm
nginx -t
systemctl reload nginx