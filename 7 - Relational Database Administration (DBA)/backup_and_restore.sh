#!bin/bash
# Download necessary file
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_script.sql
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_update_1.sql
# Create database, use downloaded file to load
mysql --host=mysql --port=3306 --user=root --password --execute="create database world_P1;"
mysql --host=mysql --port=3306 --user=root --password --execute="use world_P1;"
mysql --host=mysql --port=3306 --user=root --password --execute="source world_mysql_script.sql;"
mysql --host=mysql --port=3306 --user=root --password --execute="SELECT * FROM city WHERE countrycode='BGD';"
mysql --host=mysql --port=3306 --user=root --password --execute="source world_mysql_update_1.sql;"
mysql --host=mysql --port=3306 --user=root --password --execute="SELECT * FROM city WHERE countrycode='BGD';"
# Back Up
mysqldump --host=mysql --port=3306 --user=root --password world_P1 city > world_P1_city_mysql_backup.sql
# Drop and Restore
mysql --host=mysql --port=3306 --user=root --password --execute="DROP TABLE world_P1.city;"
mysql --host=mysql --port=3306 --user=root --password --execute="SELECT * FROM world_P1.city;"
mysql --host=mysql --port=3306 --user=root --password world_P1 < world_P1_city_mysql_backup.sql
mysql --host=mysql --port=3306 --user=root --password --execute="SELECT * FROM world_P1.city;"