select *
from FIT5137.buildings
union
select *
from FIT5137.paths
union
select *
from FIT5137.items;

insert into FIT5137.buildings
values (1120,'R-09 Meeting Room','Meeting',
st_makepolygon( st_geomfromtext('linestring(0.1 0.3, 1 0.3, 1 0.1, 0.1 0.1, 0.1
0.3)')));

insert into FIT5137.paths
values('3120','New Entrance 01','Entrance',st_geomfromtext('linestring(1.25
0.95, 1.25 1)'));

insert into FIT5137.paths
values('3121','New Entrance 02','Entrance',st_geomfromtext('linestring(1.25
0.95, 1.25 0.9)'));
insert into FIT5137.items
values('5008','Recycle Box','Misc', st_point(1.7,1.15));
insert into FIT5137.items
values('5009','Rubbish Box','Misc', st_point(1.75,1.15));
update FIT5137.paths
set geom = st_geomfromtext('linestring(1.6 0.4, 1.651 0.349)')
where object_id ='3112';


-- identify duplicate value 
select b.object_id, b.object_name
from FIT5137.buildings b, FIT5137.buildings
b2
where st_equals(b.geom, b2.geom) and
b.object_id != b2.object_id;


DELETE FROM FIT5137.buildings
WHERE object_id IN (
  SELECT b1.object_id
  FROM FIT5137.buildings b1, FIT5137.buildings b2
  WHERE ST_Equals(b1.geom, b2.geom) AND b1.object_id > b2.object_id
);

select b.object_id, b.object_name
from FIT5137.paths b, FIT5137.paths
b2
where st_equals(b.geom, b2.geom) and
b.object_id != b2.object_id;


DELETE FROM FIT5137.paths
WHERE object_id IN (
  SELECT b1.object_id
  FROM FIT5137.paths b1, FIT5137.paths b2
  WHERE ST_Equals(b1.geom, b2.geom) AND b1.object_id > b2.object_id
);

select b.object_id, b.object_name
from FIT5137.items b, FIT5137.items
b2
where st_equals(b.geom, b2.geom) and
b.object_id != b2.object_id;


DELETE FROM FIT5137.items
WHERE object_id IN (
  SELECT b1.object_id
  FROM FIT5137.items b1, FIT5137.items b2
  WHERE ST_Equals(b1.geom, b2.geom) AND b1.object_id > b2.object_id
);


-- Which rooms have the most entrances?
SELECT b.object_name, COUNT(p.object_id) AS num_entrances
FROM FIT5137.buildings b
JOIN FIT5137.paths p ON ST_Intersects(b.geom, p.geom)
WHERE p.object_type = 'Entrance'
GROUP BY b.object_name
ORDER BY num_entrances DESC
LIMIT 5;


select count(*)
from FIT5137.buildings b
where b.object_type !='Building';

--Find the number of rooms that are accessible from each corridor.  
-- A room is connected to a corridor if there is
-- an entrance to the corridor. Make sure you exclude the building in this query
SELECT c.object_name, COUNT(DISTINCT r.object_id) AS num_rooms
FROM FIT5137.paths c
JOIN FIT5137.paths e ON ST_Intersects(c.geom, e.geom) AND e.object_type = 'Entrance'
JOIN FIT5137.buildings r ON ST_Intersects(e.geom, r.geom)
WHERE c.object_type = 'Corridor'
and r.object_type != 'Building'
GROUP BY c.object_name
ORDER BY num_rooms DESC;



-- Find the room that has entrance to two corridors
SELECT r.object_name
FROM FIT5137.buildings r
JOIN FIT5137.paths e ON ST_Intersects(r.geom, e.geom) AND e.object_type = 'Entrance'
JOIN FIT5137.paths c ON ST_Intersects(e.geom, c.geom) AND c.object_type = 'Corridor'
GROUP BY r.object_name
HAVING COUNT(DISTINCT c.object_id) = 2;

-- Find the longest corridors
SELECT c.object_name, ST_Length(c.geom) AS length
FROM FIT5137.paths c
WHERE c.object_type = 'Corridor'
ORDER BY length DESC
LIMIT 5;

-- New carpet will be installed to the whole corridor areas. Find the total area for the new carpet. Exclude all
-- rooms in this calculation. Use planar as the unit. You may round the result to 2 decimal points
SELECT SUM(ST_Area(c.geom)) AS total_area
FROM FIT5137.paths c
WHERE c.object_type = 'Corridor';

--  Find the total length of all meeting rooms.
SELECT SUM(ST_Length(b.geom)) AS total_length
FROM FIT5137.buildings b
WHERE b.object_type = 'Meeting';


-- ex2
select *
from FIT5137.ltu_buildings
where object_type='Building';

insert into FIT5137.ltu_paths
values (2001,null,'Footpath',
st_geomfromtext('linestring(
145.0472854343536 -37.72052358842805,
145.04780457465796 -37.72052019385703,
145.04809953373802 -37.72051795488079,
145.04873988522672 -37.72051340458501,
145.0489619072088 -37.72051455848027,
145.04954540382903 -37.72050776574361
)')
);

insert into FIT5137.ltu_paths
values (2002,null,'Footpath',
st_geomfromtext('linestring(
145.04780457465796 -37.72052019385703,
145.0478088650081 -37.72098865024522,
145.04804268430001 -37.720981861080894,
145.0481006132364 -37.7209852556955,
145.0487355947129 -37.72097846646612,
145.04897370435495 -37.72097761782859,
145.0489619072088 -37.72051455848027
)')
);

insert into FIT5137.ltu_paths
values (2003,null,'Footpath',
st_geomfromtext('linestring(
145.0481006132364 -37.7209852556955,
145.04809953373802 -37.72051795488079,
145.0481006132364 -37.7203029376211,
145.0481091941003 -37.719932921744935
)')
);

insert into FIT5137.ltu_paths
values (2004,null,'Footpath',
st_geomfromtext('linestring(
145.0487355947129 -37.72097846646612,
145.04873988522672 -37.72051340458501,
145.04873567862444 -37.72035153172092,
145.04873567862444 -37.71992698111725
)')
);

select *
from FIT5137.ltu_paths;

insert into FIT5137.ltu_cafes
values(3001,'Graffali''s Cafe','Cafe',
st_point(145.04804054751614, -37.72075330215177));
insert into FIT5137.ltu_cafes
values(3002,'Caffeine','Cafe',
st_point(145.04849737878285, -37.72100901792871));
insert into FIT5137.ltu_cafes
values(3003,'Bachelor of Coffee','Cafe',
st_point(145.04860154020318, -37.7210022287015));

select *
from FIT5137.ltu_cafes lc ;


select * from FIT5137.ltu_buildings lb
union
select * from FIT5137.ltu_paths lb
union
select * from FIT5137.ltu_cafes lb;
