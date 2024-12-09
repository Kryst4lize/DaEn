#! /bin/bash
# This script

# Extracts data from /etc/passwd file into a CSV file.
# The csv data file contains the user name, user id and
# home directory of each user account defined in /etc/passwd
# Transforms the text delimiter from ":" to ",".
cut -d":" -f1,3,6 /etc/passwd | tr ":" "," > transformed-data.csv
# Loads the data from the CSV file into a table in PostgreSQL database.
echo "Loading data"
export PGPASSWORD='bxazT4MHgGW46V0KUW3banaU';
echo "\c template1;\COPY users  FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV;" | psql --username=postgres --host=postgres
echo "SELECT * FROM users;" | psql --username=postgres --host=postgres template1
