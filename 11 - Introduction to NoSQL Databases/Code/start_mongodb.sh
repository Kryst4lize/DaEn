#! /bin/bash

# Lab demo
mongosh mongodb://root:r0qjTfmoSMrAOGLQy2bxbs4S@172.21.165.162:27017 << EOF
db.version()

show dbs

use training

db.createCollection("mycollection")

show collections

db.mycollection.insert({"color":"white","example":"milk"})

db.mycollection.insert({"color":"blue","example":"sky"})

db.mycollection.countDocuments()

db.mycollection.find()

exit
EOF

# Practice 
mongosh mongodb://root:r0qjTfmoSMrAOGLQy2bxbs4S@172.21.165.162:27017 << EOF
show dbs 
use mydatabase
db.createCollection("landmarks")
show collections
db.landmarks.insert({"name":"Effiel Tower","city":"Paris","country":"France"})
db.landmarks.countDocuments()
db.landmarks.find()
exit 
EOF