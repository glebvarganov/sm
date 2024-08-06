#!/bin/bash

# Check for the SQL file argument
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/file.sql"
  exit 1
fi

# Parameters
SQL_FILE="$1"
CONTAINER_NAME="sm_mysql"
DB_ROOT_PASSWORD="root_password"
DB_NAME="magento"

# Check that the database file exists
if [ ! -f "$SQL_FILE" ]; then
  echo "Database file not found: $SQL_FILE"
  exit 1
fi

# Deleting the old database and creating a new one
echo "Deleting the old database and creating a new one..."
docker exec -i $CONTAINER_NAME mysql -u root -p"$DB_ROOT_PASSWORD" -e "DROP DATABASE IF EXISTS $DB_NAME; CREATE DATABASE $DB_NAME;"

# Importing the database
echo "Importing the database from the file $SQL_FILE..."
docker exec -i $CONTAINER_NAME mysql -u root -p"$DB_ROOT_PASSWORD" $DB_NAME < "$SQL_FILE"

echo "Import completed."
