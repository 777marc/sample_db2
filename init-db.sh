#!/bin/bash

# Start DB2
su - db2inst1 -c "db2start"

# Wait for DB2 to be ready
sleep 10

# Create database
su - db2inst1 -c "db2 create database $DBNAME"

# Wait for database creation
sleep 5

# Connect to database and run SQL scripts
su - db2inst1 -c "db2 connect to $DBNAME && db2 -tvf /var/custom/create-table.sql && db2 -tvf /var/custom/seed-data.sql && db2 connect reset"

# Keep container running
echo "DB2 initialization complete"
tail -f /dev/null
