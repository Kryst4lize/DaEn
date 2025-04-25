#! /bin/bash
# wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0321EN-SkillsNetwork/nosql/catalog.json
# Task 1 - Import ‘catalog.json’ into mongodb server into a database named ‘catalog’ and a collection named ‘electronics

mongosh mongodb://root:gqhtcYu2Ex4FgHSsCHx2HPtk@172.21.141.56:27017 << EOF
use catalog;
db.createCollection("electronics");
// Task 2 - List out all the databases
show dbs 

// Task 3 - List out all the collections in the database catalog.
show collections;

EOF

mongoimport --db catalog --collection electronics --type json -file catalog.json --uri


mongosh mongodb://root:gqhtcYu2Ex4FgHSsCHx2HPtk@172.21.141.56:27017 << EOF
use catalog
// Task 4 - Create an index on the field “type”
db.electronics.createIndex("type")

// Task 5 - Write a query to find the count of laptops
db.electronics.aggregate([
    {$match:{type:"laptop"}},
    {$count: "count_laptops"}
])

// Task 6 - Write a query to find the number of smart phones with screen size of 6 inches.
db.electronics.aggregate([
  {$match:{type:"smart phone"}},
  {$match:{"screen size":6}},
  {$count: "Number_of_6_inches_smartphones"}
]);
Task 7. Write a query to find out the average screen size of smart phones.
db.electronics.aggregate([
  {$match:{type:"smart phone"}},
  {
    $group: {
      _id: "$type", // Group by screen size
      average_amount: { $avg: "$screen size" }
    }
  }
]);
EOF

# Task 8 - Export the fields _id, “type”, “model”, from the ‘electronics’ collection into a file named electronics.csv
mongoexport -u root -p gqhtcYu2Ex4FgHSsCHx2HPtk --db=catalog --collection=electronics  --type=csv --fie
lds=_id,type,model --out=electronic.csv