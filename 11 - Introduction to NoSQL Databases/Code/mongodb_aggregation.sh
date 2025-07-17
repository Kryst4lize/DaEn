#! /bin/bash
# Exercise 5 - Group by
# The operator $group by, along with operators like $sum, $avg, $min, $max, allows us to perform grouping operations.
#This aggregation pipeline prints the average marks across all subjects.
mongosh mongodb://root:r0qjTfmoSMrAOGLQy2bxbs4S@172.21.165.162:27017 << EOF

use training
db.createCollection("marks")
db.marks.insertOne({"name":"Ramesh","subject":"maths","marks":87})
db.marks.insertOne({"name":"Ramesh","subject":"english","marks":59})
db.marks.insertOne({"name":"Ramesh","subject":"science","marks":77})
db.marks.insertOne({"name":"Rav","subject":"maths","marks":62})
db.marks.insertOne({"name":"Rav","subject":"english","marks":83})
db.marks.insertOne({"name":"Rav","subject":"science","marks":71})
db.marks.insertOne({"name":"Alison","subject":"maths","marks":84})
db.marks.insertOne({"name":"Alison","subject":"english","marks":82})
db.marks.insertOne({"name":"Alison","subject":"science","marks":86})
db.marks.insertOne({"name":"Steve","subject":"maths","marks":81})
db.marks.insertOne({"name":"Steve","subject":"english","marks":89})
db.marks.insertOne({"name":"Steve","subject":"science","marks":77})
db.marks.insertOne({"name":"Jan","subject":"english","marks":0,"reason":"absent"})

db.marks.aggregate([{"\$limit":2}])
db.marks.aggregate([{"\$sort":{"marks":1}}])
db.marks.aggregate([{"\$sort":{"marks":-1}}])

db.marks.aggregate([{"\$sort":{"marks":-1}}, {"\$limit":2}])
db.marks.aggregate([
{
    "\$group":
    {
        "_id":"\$subject",
        "average_score":{"\$avg":"\$marks"}
    }
}
])

db.marks.aggregate([
    {"\$group":{
        "_id":"\$name",
        "avg_score_student":{"\$avg":"\$marks"}
    }},
    {"\$sort":{"avg_score_student":-1}},
    {"\$limit":2}
]
)
EOF