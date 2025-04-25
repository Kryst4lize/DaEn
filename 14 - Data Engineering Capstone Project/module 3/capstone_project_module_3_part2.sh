#! /bin/bash
# wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/nm75oOK5n7AGME1F7_OIQg/CREATE-SCRIPT.sql

# Create test1 database
export PGPASSWORD=3mPAJpeRlKZ1Ej1ScRc36W0n; psql --host 172.21.206.31 -p 5432 -U postgres << EOF
CREATE DATABASE test1; 
\c test1;
EOF

# Import SQL schema;
export PGPASSWORD=3mPAJpeRlKZ1Ej1ScRc36W0n; psql --host 172.21.206.31 -p 5432 -U postgres test1 < CREATE-SCRIPT.sql

#Task 1 - Load data into the dimension table DimDate
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0321EN-SkillsNetwork/datawarehousing/data/DimDate.csv

export PGPASSWORD=3mPAJpeRlKZ1Ej1ScRc36W0n; psql --host 172.21.206.31 -p 5432 -U postgres -d test1 << EOF
\copy "DimDate" FROM 'DimDate.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
EOF

# Task 2 - Load data into the dimension table DimCategory
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0321EN-SkillsNetwork/datawarehousing/DimCategory.csv
export PGPASSWORD=3mPAJpeRlKZ1Ej1ScRc36W0n; psql --host 172.21.206.31 -p 5432 -U postgres -d test1 << EOF
\copy "DimCategory" FROM 'DimCategory.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
EOF

# Task 3 - Load data into the dimension table DimCountry
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0321EN-SkillsNetwork/datawarehousing/DimCountry.csv
export PGPASSWORD=3mPAJpeRlKZ1Ej1ScRc36W0n; psql --host 172.21.206.31 -p 5432 -U postgres -d test1 << EOF
\copy "DimCountry" FROM 'DimCountry.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
EOF

# Task 4 - Load data into the fact table FactSales
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0321EN-SkillsNetwork/datawarehousing/FactSales.csv
export PGPASSWORD=3mPAJpeRlKZ1Ej1ScRc36W0n; psql --host 172.21.206.31 -p 5432 -U postgres -d test1 << EOF
\copy "FactSales" FROM 'FactSales.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
EOF

export PGPASSWORD=3mPAJpeRlKZ1Ej1ScRc36W0n; psql --host 172.21.206.31 -p 5432 -U postgres -d test1 << EOF
SELECT B.Year, C.country, D.category, SUM(amount)
FROM "FactSales" AS A 
INNER JOIN "DimDate" AS B ON A.dateid = B.dateid 
INNER JOIN "DimCountry" AS C on A.countryid = C.countryid
INNER JOIN "DimCategory" AS D on A.categoryid = D.categoryid
GROUP BY
GROUPING SETS ((B.Year, C.country, D.category))
ORDER BY C.country, D.category, B.Year;

SELECT B.Year, C.country, SUM(amount)
FROM "FactSales" AS A 
INNER JOIN "DimDate" AS B ON A.dateid = B.dateid 
INNER JOIN "DimCountry" AS C on A.countryid = C.countryid
GROUP BY
ROLLUP (B.Year, C.country)
ORDER BY C.country, B.Year;

SELECT B.Year, C.country, AVG(amount)
FROM "FactSales" AS A 
INNER JOIN "DimDate" AS B ON A.dateid = B.dateid 
INNER JOIN "DimCountry" AS C on A.countryid = C.countryid
GROUP BY
CUBE (B.Year, C.country)
ORDER BY C.country, B.Year;

CREATE MATERIALIZED VIEW IF NOT EXISTS total_sales_per_country AS
(
    SELECT C.country, SUM(amount)
    FROM "FactSales" AS A 
    INNER JOIN "DimCountry" AS C on A.countryid = C.countryid
    GROUP BY country
    ORDER BY C.country
);
EOF