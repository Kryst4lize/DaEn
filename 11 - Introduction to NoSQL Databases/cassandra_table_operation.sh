#! /bin/bash
cqlsh 172.21.10.37 9042 --username root --password hTHKFjj0Xn6fCR4y8TcBXeyF<<EOF
CREATE KEYSPACE training
WITH replication= {'class':'SimpleStrategy','replication_factor':3};
DESCRIBE training;

USE training;
CREATE TABLE movies(
    movie_id int PRIMARY KEY,
    movie_name TEXT,
    year_of_release INT
    );
describe TABLES;
describe movies;

ALTER TABLE movies
ADD genre TEXT;
describe movies;
EOF