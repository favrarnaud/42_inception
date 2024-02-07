#!/bin/bash

while ! mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $WP_DATABASE_NAME &>/dev/null; do
  sleep 3
done

mkdir -p /run/php/;
touch /run/php/php7.3-fpm.pid;

if [ ! -f /var/www/html/wp-config.php ]; then
  chown -R www-data:www-data /var/www/*
  chmod -R 755 /var/www/*
  mkdir -p /var/www/html
  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp
  cd /var/www/html || exit
  wp core download --allow-root
  wp config create --dbname=$WP_DATABASE_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
  wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
  wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
fi

exec "$@"