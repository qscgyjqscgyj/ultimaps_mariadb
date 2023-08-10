#!/bin/bash

dump_file="dump.sql"

remote_db_host="ultimaps-db-dev.cqghatbz6fme.us-east-2.rds.amazonaws.com"
remote_db_name="ultimaps"
remote_db_username="ultimaps"
remote_db_password=""

local_db_host="localhost"
local_db_name="ultimaps"
local_db_username="ultimaps"
local_db_password="password"

# Check if the dump file exists
if [ ! -f "$dump_file" ]; then
    # Execute mysqldump command to create the dump file
    mysqldump -h "$remote_db_host" -u $remote_db_username -p"$remote_db_password" $remote_db_name > "$dump_file"
    echo "Dump file created: $dump_file"
else
    echo "Dump file already exists: $dump_file"
fi

# Check if the local database has no tables
table_count=$(mysql -N -B -h $local_db_host -u "$local_db_username" -p"$local_db_password" -e "USE $local_db_name; SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '$local_db_name';")

if [ "$table_count" -eq 0 ]; then
    # Load the dump file into the local database
    mysql -h $local_db_host -u "$local_db_username" -p"$local_db_password" "$local_db_name" < "$dump_file"
    echo "Dump file loaded into the local database"
else
    echo "Local database is not empty"
fi
