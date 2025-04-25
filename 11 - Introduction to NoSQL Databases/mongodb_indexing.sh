mongosh mongodb://root:r0qjTfmoSMrAOGLQy2bxbs4S@172.21.165.162:27017 << EOF
db.version()
use training
db.createCollection("bigdata")

use training
for (i=1;i<=200000;i++){print(i);db.bigdata.insertOne({"account_no":i,"balance":Math.round(Math.random()*1000000)})}
db.bigdata.countDocuments()

db.bigdata.find({"account_no":58982}).explain("executionStats").executionStats.executionTimeMillis
db.bigdata.createIndex({"account_no":1})
db.bigdata.getIndexes()
db.bigdata.find({"account_no": 69271}).explain("executionStats").executionStats.executionTimeMillis
db.bigdata.dropIndex({"account_no":1})
EOF