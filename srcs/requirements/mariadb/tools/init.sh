#!/bin/bash
set -e

# Ensure the mysqld runtime directory exists
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# If database system tables don't exist, initialize them
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB system tables..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# Create a temporary SQL script with initialization commands
INIT_FILE=/tmp/init.sql

cat << EOF > ${INIT_FILE}
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
EOF

echo "Starting MariaDB with init file..."
# Execute mysqld directly with the init file (PID 1)
exec mysqld --user=mysql --init-file=${INIT_FILE}