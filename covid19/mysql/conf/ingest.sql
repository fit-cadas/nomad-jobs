USE geolocations;

CREATE TABLE bases( 
name varchar(255), 
state varchar(255), 
geohash varchar(255),
confirmed float,
timestamp timestamp not null default current_timestamp on update current_timestamp
);

LOAD DATA INFILE '/local/data/af_bases.csv' 
INTO TABLE bases
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(name, state, geohash, confirmed);