#! /bin/bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0321EN-SkillsNetwork/ETL/sales.sql
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/BFgMvlR8BKEjijGlWowK1Q/mysqlconnect.py

# Create database sales and import data 
mysql --host=172.21.237.67 --port=3306 --user=root --password=4eKrQd1i3vVMcIuusyyOCe6G << EOF
CREATE DATABASE IF NOT EXISTS sales;
EOF
mysql --user=root --password=4eKrQd1i3vVMcIuusyyOCe6G -p sales < sales.sql
# Replace Password (4eKrQd1i3vVMcIuusyyOCe6G) and host (172.21.111.118) params to current project 
pip install mysql-connector-python
python3.11 mysqlconnect.py
# ProgresSQL connector
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/OHNZDzk-BAcrpy75I0DCoA/postgresqlconnect.py
# Replace with coressponding parameter 
python3 -m pip install psycopg2
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/sales-csv3mo8i5SHvta76u7DzUfhiw.csv

wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0321EN-SkillsNetwork/ETL/automation.py
# Import data
export PGPASSWORD=TRIdmMHhWRgbJDdNqwzwyK5Q; sed '1d' sales-csv3mo8i5SHvta76u7DzUfhiw.csv | psql --host 172.21.229.130 -p 5432 -U postgres -d postgres -c "\copy sales_data FROM 
PSTDIN WITH (FORMAT CSV, DELIMITER ',');"
echo "Import successfully \n"
python3.11 postgresqlconnect.py
python3.11 automation.py

