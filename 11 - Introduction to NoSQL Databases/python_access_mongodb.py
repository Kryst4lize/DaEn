import os
os.system("python3 -m pip install pymongo")

from pymongo import MongoClient
user = 'root'
password = 'r0qjTfmoSMrAOGLQy2bxbs4S'
host='mongo'
#create the connection url
connecturl = "mongodb://{}:{}@{}:27017/?authSource=admin".format(user,password,host)

# connect to mongodb server
print("Connecting to mongodb server")
connection = MongoClient(connecturl)

# get database list
print("Getting list of databases")
dbs = connection.list_database_names()

# print the database names

for db in dbs:
    print(db)
print("Closing the connection to the mongodb server")

# close the server connecton
connection.close()