#! /bin/bash

# CREATE DATABASE AND TABLE SCHEMA
mysql --host=172.21.249.140 --port=3306 --user=root --password=lEINaLfQezJIX9jVH2CzxvnZ << EOF
CREATE DATABASE sales;
USE sales;
CREATE TABLE sales_data(
    product_id INT PRIMARY KEY,
    customer_id INT,
    price INT,
    quantity INT,
    timestamp TIMESTAMP
);
EOF

# IMPORT THE DATA
## Download file
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0321EN-SkillsNetwork/oltp/oltpdata.csv
## Rename
mv oltpdata.csv sales_data.csv
mysql -u root -p sales --password=lEINaLfQezJIX9jVH2CzxvnZ  < sales_data.sql
# List the table in the area, write a query to find out the count of records in the tables sales_data.

# CREATE DATABASE AND TABLE SCHEMA
mysql --host=172.21.249.140 --port=3306 --user=root --password=lEINaLfQezJIX9jVH2CzxvnZ << EOF
CREATE DATABASE sales;
USE sales;
SHOW TABLES;
SELECT COUNT(*) FROM sales_data ;
EOF

# CREATE AN INDEX AND LIST INDEX
mysql --host=172.21.249.140 --port=3306 --user=root --password=lEINaLfQezJIX9jVH2CzxvnZ << EOF
CREATE DATABASE sales;
USE sales;
CREATE INDEX sales_table ON sales_table(timestamp);
SHOW INDEXES FROM sales_table;
EOF

# Export table
mysqldump -u root -p sales sales_data --password=lEINaLfQezJIX9jVH2CzxvnZ > sales_data.sql