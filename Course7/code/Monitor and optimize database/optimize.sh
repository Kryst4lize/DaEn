#!bin/bash
# download the database employees
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/employeesdb.zip
unzip employeesdb.zip
cd employeesdb
# recommend to have no password or put the password in the parameter --password=yourpassword
mysql --host=mysql --port=3306 --user=root --password -t < employees.sql