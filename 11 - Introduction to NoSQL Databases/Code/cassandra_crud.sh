#! /bin/bash
cqlsh 172.21.10.37 9042 --username root --password hTHKFjj0Xn6fCR4y8TcBXeyF<<EOF
CREATE KEYSPACE training
WITH replication ={ 'class':'SimpleStrategy','replication_factor':3};
USE training;
CREATE TABLE movies(
    movie_id INT PRIMARY KEY,
    movie_name TEXT,
    year_of_release INT
);
INSERT INTO movies(movie_id, movie_name, year_of_release) VALUES (1,'Toy Story', 1995);
select * from movies;

select movie_name from movies where movie_id = 1;

UPDATE movies
SET year_of_release = 1996
WHERE movie_id = 4;
select * from movies where movie_id = 4;
EOF