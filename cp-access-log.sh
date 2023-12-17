#!/bin/bash

# Download the access log file
wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

# Unzip the file to extract the .txt file.
gunzip -f web-server-access-log.txt.gz

# Extract phase
echo "Extracting data"

# Extract the columns 1 (timestamp), 2 (latitude), 3 (longitude), and 4 (visitorid)
cut -d"#" -f1-4 web-server-access-log.txt > extracted-data.txt

# Transform phase
echo "Transforming data"

# Replace delimiters from "#" to ","
tr "#" "," < extracted-data.txt > transformed-data.csv

# Load phase
echo "Loading data"

# Send the instructions to connect to 'template1' and
# copy the file to the table 'access_log' through command pipeline.
echo "\c template1; \COPY access_log FROM '/mnt/c/Users/Toby/Documents/ETL-pipeline/transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost -p 5433
