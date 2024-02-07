#!/bin/bash

env > /tmp/envfile
cat << EOF > /tmp/init_db.sql
CREATE DATABASE IF NOT EXISTS $WP_DATABASE_NAME;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $WP_DATABASE_NAME.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

mysql -h localhost < /tmp/init_db.sql
#rm -rf /tmp/init_db.sql
#rm -rf /tmp/configure.sh