#! /bin/bash
# Install requirement file 
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0321EN-SkillsNetwork/ETL/sales.sql
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/BFgMvlR8BKEjijGlWowK1Q/mysqlconnect.py
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/OHNZDzk-BAcrpy75I0DCoA/postgresqlconnect.py
# Connecting Server
mysql --host=172.21.111.118 --port=3306 --user=root --password=FrdLwRfVVz23UoPaEk4NFjeU << EOF
CREATE DATABASE sales;
USE sales;
EOF
# Import data from requirement file
mysql --user=root -p sales --password=FrdLwRfVVz23UoPaEk4NFjeU < sales.sql
# Replace Password (FrdLwRfVVz23UoPaEk4NFjeU) and host (172.21.111.118) params to current project 
python3.11 mysqlconnect.py