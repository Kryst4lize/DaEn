#download the data file
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/labs/Final%20Assignment/vehicle-data.csv

#download the sql file

wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/labs/Final%20Assignment/setup.sql

#run the sql file

psql --username=postgres --host 172.21.15.32 --password -p 5432 -f setup.sql

#import the csv file

cat vehicle-data.csv | psql --username=postgres -d tolldata --host=172.21.15.32 --password -p 5432 -c "copy toll.tolldata from STDIN WITH (FORMAT csv);"
