#! /bin/bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0321EN-SkillsNetwork/ETL/accesslog.txt
mkdir airflow/dags/capstone
mv accesslog.txt airflow/dags/capstone/accesslog.txt

# After create process_web_log file; move it to airflow dags
airflow dags list 
airflow dags unpause process_web_log
