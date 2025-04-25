#! /bin/bash
cqlsh 172.21.10.37 9042 --username root --password hTHKFjj0Xn6fCR4y8TcBXeyF << EOF
CREATE KEYSPACE training  
WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 3};

describe training

ALTER KEYSPACE training 
WITH replication = {'class':'NetworkTopologyStrategy'};
describe training;

DROP KEYSPACE training;
USE system;
DESCRIBE KEYSPACES
EOF

# Practice 
cqlsh 172.21.10.37 9042 --username root --password hTHKFjj0Xn6fCR4y8TcBXeyF << EOF
CREATE KEYSPACE sales
WITH replication = {'class':'SimpleStrategy','replication_factor':1};

ALTER KEYSPACE sales
WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 3};
DESCRIBE sales;

DROP KEYSPACE sales;
DESCRIBE KEYSPACES;
EXIT;
EOF