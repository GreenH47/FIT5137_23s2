create schema FIT5137;

create table FIT5137.test_objects
(shape_name varchar(20) primary key,
geom geometry);


select st_point(145,-37.75);


select st_geomfromtext('Point(145 -37.75)');


insert into FIT5137.test_objects values ('office', st_point(145,-37.75));

select * from FIT5137.test_objects;

--line
select st_makeline(
   st_point(144.99986636637007, -37.749310207326665),
   st_point(145.00203466395763,-37.74952530913456)) ;
  
select st_geomfromtext('
          linestring(
            145.04810519958826 -37.72098656319669,
            145.04809645282967 -37.72051718925044)');  
           
select st_makeline(
  st_geomfromtext('linestring(145.04810519958826 -37.72098656319669,
                             145.04809645282967 -37.72051718925044)'
                 ),
  st_makeline(
      st_point(145.04809645282967, -37.72051718925044),
      st_point(145.04873621696018,-37.72051379746146)
              )
);

select st_geomfromtext(
  'linestring(145.0474827884346 -37.72100000786857,           
              145.04810519958826 -37.72098656319669,
              145.04809645282967 -37.72051718925044,
              145.04873621696018 -37.72051379746146)'
);
--Insert a new line using 2 new defined points
insert into FIT5137.test_objects values ('agora_north',
st_makeline(
  st_point(145.04809645282967, -37.72051718925044),
  st_point(145.04873621696018,-37.72051379746146)));
 
--Insert a new line using linestring WKT format
insert into FIT5137.test_objects values ('agora_west', st_geomfromtext(
'linestring(145.04810519958826 -37.72098656319669,
            145.04809645282967 -37.72051718925044)'));
           
           
--Displaying  the objects that have “agora” as part of the name
select * from FIT5137.test_objects
where shape_name like 'agora%';


--polygon
select st_geomfromtext(
'linestring(0.3 1.2, 
            0.5 1.2, 
            0.5 1.0, 
            0.3 1.0, 
            0.3 1.2)');
           
select st_makepolygon(
            st_geomfromtext('linestring(0.3 1.2, 0.5 1.2, 0.5 1.0, 0.3 1.0, 0.3 1.2)'));
           
INSERT INTO FIT5137.test_objects
values ('square',st_makepolygon(
            st_geomfromtext('linestring(0.3 1.2, 0.5 1.2, 0.5 1.0, 0.3 1.0, 0.3 1.2)')));

select * from FIT5137.test_objects;

/*
****************************
Part A
****************************
*/
--task 1
drop table FIT5137.buildings;

create table FIT5137.buildings
(
 object_id  	int primary key,
 object_name 	varchar(50) not null,
 object_type 	varchar(10) not null check (object_type in ('Meeting','Office','Toilet','Kitchen','Common','Building','Utility')),
 geom 	geometry not null
);


CREATE TABLE FIT5137.paths
(
 object_id  	numeric(8) PRIMARY KEY,
 object_name 	VARCHAR(50) NOT NULL,
 object_type 	VARCHAR(10) NOT NULL CHECK (object_type IN ('Corridor', 'Entrance')),
 geom 	GEOMETRY not null
);


CREATE TABLE FIT5137.items
(
 object_id  	numeric(8) PRIMARY KEY,
 object_name 	VARCHAR(50) NOT NULL,
 object_type 	VARCHAR(10) NOT NULL CHECK (object_type IN ('Appliances','Devices','Tools','Misc')),
 geom 	GEOMETRY not null
);

--show tables
--select
--	table_name,table_schema 
--from
--	information_schema.tables
--where
--	upper(table_schema) = upper('FIT5137')
--	and table_name in ('buildings', 'paths', 'items');

--task 2:

select st_makepolygon( st_geomfromtext(
						'linestring(0.1 0.1, 0.1 0.3, 0.1 0.8, 0.1 1.2, 
						0.3 1.2, 0.5 1.2, 
						0.5 1.0, 0.5 0.9, 
						0.6 0.9, 0.7 0.9, 
						0.7 1.2, 0.9 1.2, 
						1.4 1.2, 1.6 1.2, 2.0 1.2, 
						2.0 0.6, 2.0 0.5, 
						1.6 0.1, 1.4 0.1, 1.2 0.1, 1.1 0.1, 1.0 0.1, 0.1 0.1)')); 

					
insert into FIT5137.buildings
values (1000,'Atlantis','Building',
st_makepolygon( st_geomfromtext('linestring(0.1 0.1, 0.1 0.3, 0.1 0.8, 0.1 1.2, 
						0.3 1.2, 0.5 1.2, 
						0.5 1.0, 0.5 0.9, 
						0.6 0.9, 0.7 0.9, 
						0.7 1.2, 0.9 1.2, 
						1.4 1.2, 1.6 1.2, 2.0 1.2, 
						2.0 0.6, 2.0 0.5, 
						1.6 0.1, 1.4 0.1, 1.2 0.1, 1.1 0.1, 1.0 0.1, 0.1 0.1)'))
);

select * from FIT5137.buildings;

-- R-01
insert into FIT5137.buildings
values (1101,'R-01 Discussion Room','Meeting',
st_makepolygon( st_geomfromtext('linestring(0.3 1.2, 0.5 1.2, 0.5 1, 0.3 1, 0.3 1.2)')));

-- R-02
insert into FIT5137.buildings
values (1102,'R-02 Discussion Room','Meeting',
st_makepolygon( st_geomfromtext('linestring(0.1 1.2, 0.3 1.2, 0.3 1, 0.3 0.8, 0.1 0.8, 0.1 1.2)')));
-- R-03
insert into FIT5137.buildings
values (1103,'R-03 Presentation Room','Meeting',
st_makepolygon( st_geomfromtext('linestring(0.1 0.8, 0.3 0.8, 0.3 0.3, 0.1 0.3, 0.1 0.8)')));
-- R-04
insert into FIT5137.buildings
values (1104,'R-04 Meeting Room','Meeting',
st_makepolygon( st_geomfromtext('linestring(0.1 0.3, 1 0.3, 1 0.1, 0.1 0.1, 0.1 0.3)')));
-- R-05
insert into FIT5137.buildings
values (1105,'R-05 Staff Room','Office',
st_makepolygon( st_geomfromtext('linestring(0.4 0.8, 0.8 0.8, 0.8 0.4, 0.4 0.4, 0.4 0.8)')));

-- R-06
insert into FIT5137.buildings
values (1106,'R-06 Administration','Office',
st_makepolygon( st_geomfromtext('linestring(0.8 0.8, 1 0.8, 1 0.4, 0.8 0.4, 0.8 0.8)')));
-- R-08
insert into FIT5137.buildings
values (1108,'R-08 Finance','Office',
st_makepolygon( st_geomfromtext('linestring(0.7 1.2, 0.9 1.2, 0.9 0.9, 0.7 0.9, 0.7 1.2)')));
-- R-09
insert into FIT5137.buildings
values (1109,'R-09 Director','Office',st_makepolygon( st_geomfromtext('linestring(0.9 1.2, 1.4 1.2, 1.4 1, 0.9 1, 0.9 1.2)')));
-- R-10
insert into FIT5137.buildings
values (1110,'R-10 IT Development','Office',
st_makepolygon( st_geomfromtext('linestring(1.2 0.9, 1.7 0.9, 1.7 0.6, 1.5 0.4, 1.2 0.4, 1.2 0.9)')));
-- Toilet A
insert into FIT5137.buildings
values (1201,'Toilet A','Toilet',
st_makepolygon( st_geomfromtext('linestring(1.2 0.3, 1.4 0.3, 1.4 0.1, 1.2 0.1, 1.2 0.3)')));
-- Toilet B
insert into FIT5137.buildings
values (1202,'Toilet B','Toilet',
st_makepolygon( st_geomfromtext('linestring(1.4 0.3, 1.6 0.3, 1.6 0.1, 1.4 0.1, 1.4 0.3)')));
-- utility Room
insert into FIT5137.buildings
values (1301,'Utility Room','Utility',
st_makepolygon( st_geomfromtext('linestring(1.6 0.3, 1.8 0.5, 2 0.5, 1.6 0.1, 1.6 0.3)')));

-- Kitchen
insert into FIT5137.buildings
values (1401,'Kitchen','Kitchen',
st_makepolygon( st_geomfromtext('linestring(1.6 1.2, 2 1.2, 2 0.6, 1.7 0.6, 1.7 0.9, 1.6 0.9, 1.6 1.2)')));

select * from FIT5137.buildings;


--task 3 Path Construction

insert into FIT5137.paths
values('3001','Left Corridor','Corridor',
     st_geomfromtext('linestring( 1.1 0.85, 
                                  0.85 0.85, 
                                  0.75 0.85, 
                                  0.6 0.85, 
                                  0.45 0.85, 
                                  0.45 0.95, 
                                  0.35 0.95, 
                                  0.35 0.85, 
                                  0.35 0.75, 
                                  0.35 0.35, 
                                  0.75 0.35, 
                                  0.95 0.35, 1.1	 0.35)'));
                                 
                                 
insert into FIT5137.paths
values('3002','Right Corridor','Corridor',st_geomfromtext('linestring(1.1 0.95, 1.25 0.95, 1.6 0.95, 1.8 0.95, 1.8 0.85, 1.8 0.6, 1.6 0.4, 1.55 0.35, 1.45 0.35, 1.35 0.35, 1.25 0.35, 1.1 0.35)'));

insert into FIT5137.paths
values('3003','Center Corridor','Corridor',st_geomfromtext('linestring(1.1 0.1, 1.1 0.35, 1.1 0.85, 1.1 0.95)'));       

--entrance
insert into FIT5137.paths
values('3101','Entrance','Entrance',st_geomfromtext('linestring(0.6 0.9, 0.6 0.85)'));
insert into FIT5137.paths
values('3102','Entrance','Entrance',st_geomfromtext('linestring(0.45 0.95, 0.45 1)'));
insert into FIT5137.paths
values('3103','Entrance','Entrance',st_geomfromtext('linestring(0.35 0.85, 0.3 0.85)'));
insert into FIT5137.paths
values('3104','Entrance','Entrance',st_geomfromtext('linestring(0.35 0.75, 0.3 0.75)'));
insert into FIT5137.paths
values('3105','Entrance','Entrance',st_geomfromtext('linestring(0.35 0.35, 0.35 0.3)'));
insert into FIT5137.paths
values('3106','Entrance','Entrance',st_geomfromtext('linestring(0.75 0.35, 0.75 0.4)'));
insert into FIT5137.paths
values('3107','Entrance','Entrance',st_geomfromtext('linestring(0.95 0.35, 0.95 0.3)'));
insert into FIT5137.paths
values('3108','Entrance','Entrance',st_geomfromtext('linestring(0.95 0.35, 0.95 0.4)'));
insert into FIT5137.paths
values('3109','Entrance','Entrance',st_geomfromtext('linestring(1.25 0.35, 1.25 0.4)'));
insert into FIT5137.paths
values('3110','Entrance','Entrance',st_geomfromtext('linestring(1.35 0.35, 1.35 0.3)'));
insert into FIT5137.paths
values('3111','Entrance','Entrance',st_geomfromtext('linestring(1.45 0.35, 1.45 0.3)'));
insert into FIT5137.paths
values('3112','Entrance','Entrance',st_geomfromtext('linestring(1.6 0.4, 1.65 0.35)'));
insert into FIT5137.paths
values('3113','Entrance','Entrance',st_geomfromtext('linestring(1.8 0.85, 1.7 0.85)'));
insert into FIT5137.paths
values('3114','Entrance','Entrance',st_geomfromtext('linestring(1.25 0.95, 1.25 1)'));
insert into FIT5137.paths
values('3115','Entrance','Entrance',st_geomfromtext('linestring(1.25 0.95, 1.25 0.9)'));
insert into FIT5137.paths
values('3116','Entrance','Entrance',st_geomfromtext('linestring(1.1 0.95, 0.9 0.95)'));
insert into FIT5137.paths
values('3117','Entrance','Entrance',st_geomfromtext('linestring(0.85 0.85, 0.85 0.8)'));
insert into FIT5137.paths
values('3118','Entrance','Entrance',st_geomfromtext('linestring(0.75 0.85, 0.75 0.8)'));

select * from FIT5137.paths;


select * 
from FIT5137.buildings
union
select * 
from FIT5137.paths;

--task 4
--item defintiation
-- kitechen Beach: 
insert into FIT5137.items 
values('5305','Kitchen Bench','Misc', st_makepolygon(st_geomfromtext('linestring(1.8 1.2, 2 1.2, 
2 0.95, 1.95 0.95, 1.95 1.15, 1.8 1.15, 1.8 1.2)'))); 

-- bin
insert into FIT5137.items
values('5001','Recycle Bin','Misc', st_point(0.325,0.975));
insert into FIT5137.items
values('5002','Recycle Bin','Misc', st_point(0.325,0.325));
insert into FIT5137.items
values('5003','Recycle Bin','Misc', st_point(1.7,1.15));
insert into FIT5137.items
values('5004','Rubbish Bin','Misc', st_point(1.75,1.15));
-- devices
insert into FIT5137.items
values('5101','LCD Projector','Devices', st_point(0.2, 0.35));
insert into FIT5137.items
values('5102','LCD Projector','Devices', st_point(0.9, 0.2));
insert into FIT5137.items
values('5103','Video Conference Device','Devices', st_point(0.8, 0.2));
insert into FIT5137.items
values('5104','Photocopier','Devices', st_point(1.45,1.15));
insert into FIT5137.items
values('5105','Server Rack','Devices', st_point(1.6, 0.6));
-- tools
insert into FIT5137.items
values('5201','Climate Control','Tools', st_point(0.95, 0.45));
-- Appliances
insert into FIT5137.items
values('5301','Fridge','Appliances', st_point(1.95, 0.9));
insert into FIT5137.items
values('5302','Microwave','Appliances', st_point(1.95, 1));
insert into FIT5137.items
values('5303','Coffee Maker','Appliances', st_point(1.95, 1.05));
insert into FIT5137.items
values('5304','Sink','Appliances', st_point(1.9, 1.15));

select * from FIT5137.items;

select *
from FIT5137.buildings
union
select *
from FIT5137.paths
union
select *
from FIT5137.items;
