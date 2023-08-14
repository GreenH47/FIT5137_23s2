/*
Task 1:
You need to make sure that the input data to the data warehouse has undergone a
reasonable data cleaning process, in order to make sure that the data in the data
warehouse is accurate
*/

create table region2 as
select * from dtaniar.region2;
select * from region2;

create table nation2 as
select * from dtaniar.nation2;
select * from nation2;

create table category2 as
select * from dtaniar.category2;
select * from category2;
--delete the null value in category2
delete from category2 where upper(category2.CAT_DESC) = 'NULL';


create table item2 as
select * from dtaniar.item2;
select * from item2;
-- check the duplicate i_itemkey value in item2
select i.I_ITEMKEY, count(*) from item2 i group by i.I_ITEMKEY having count(*) > 1;

create table bidpackage2 as
select * from dtaniar.bidpackage2;
select * from bidpackage2;

create table customer2 as
select * from dtaniar.customer2;
select * from customer2;
--check the duplicate c_name value in customer2
SELECT C_NAME, COUNT(*)
FROM CUSTOMER2
GROUP BY C_NAME
HAVING COUNT(*) > 1;

--check the duplicate c_name value in customer2 and list the whole row
select * from customer2 c2 where c2.c_name in (select c.c_name from customer2 c group by c.c_name having count(*) > 1);






create table auction2 as
select * from dtaniar.auction2;
select * from auction2;
-- check if there is any duplicate a_auctionkey value in auction2
select a.A_AUCTIONKEY, count(*) from auction2 a group by a.A_AUCTIONKEY having count(*) > 1;
-- check if there is any duplicate a_auctionkey value in auction2 and list the whole row
select *
from auction2 a2
where a2.a_auctionkey in (select a.a_auctionkey from auction2 a group by a.a_auctionkey having count(*) > 1);

-- check if there is any duplicate a_auctionkey value in auction2 and delete the duplicate row
delete
from auction2 a2
where a2.a_auctionkey in (select a.a_auctionkey from auction2 a group by a.a_auctionkey having count(*) > 1);


create table buyauction2 as
select * from dtaniar.buyauction2;
select * from buyauction2;
-- check if there are duplicate ba_auctionkey value in buyauction2 AND list the whole row
select *
from buyauction2 ba2
where ba2.ba_auctionkey in (select ba.ba_auctionkey from buyauction2 ba group by ba.ba_auctionkey having count(*) > 1);


create table bidding2 as
select * from dtaniar.bidding2;
select * from bidding2;

/*
create data warehouse
*/
-- create dimension table
create table DIM_ITEM as
select i.I_ITEMKEY,i.I_NAME,i.I_RETAILPRICE
from item2 i;
select * from DIM_ITEM;

-- create DIM_LOCATION table from region2 and nation2
-- with locationID(r_name +'-'+ n_name) as primary key
create table DIM_LOCATION as
select r.R_NAME, n.N_NAME, r.R_NAME||'-'||n.N_NAME as locationID
from region2 r, nation2 n
where r.R_REGIONKEY = n.N_REGIONKEY;
select * from DIM_LOCATION;

--create DIM_CATEGORY table
create table DIM_CATEGORY as
select c.CAT_DESC, c.CAT_CATEGORYKEY
from category2 c;
select * from DIM_CATEGORY;

--create new DIM_season table with seasonID,s_desc,s_start,s_end columns
CREATE TABLE DIM_season (
    seasonID number,
    s_desc VARCHAR2(50),
    s_start VARCHAR2(50),
    s_end VARCHAR2(50)
);
insert into DIM_season values (1,'Spring','September','November');
insert into DIM_season values (2,'Summer','December','February');
insert into DIM_season values (3,'Autumn','March','May');
insert into DIM_season values (4,'Winter','June','August');
select * from DIM_season;

--create fact_temp table with locationID,a_endtime,i_itemkey,cat_categorykey,
--i_retailprice,a_auctionkey
drop table fact_temp;

create table fact_temp as
select r.R_NAME||'-'||n.N_NAME as locationID, a.a_endtime, i.i_itemkey, c.cat_categorykey, i.i_retailprice, a.a_auctionkey
from auction2 a, item2 i, category2 c, DIM_LOCATION l,customer2 cu,nation2 n,region2 r
where a.a_itemkey = i.i_itemkey
and i.i_categorykey = c.cat_categorykey
and cu.C_NATIONKEY = n.N_NATIONKEY
and r.R_REGIONKEY = n.N_REGIONKEY
and a.A_USERNAME = cu.C_USERNAME;
select * from fact_temp;

-- add and update the fact_temp table with seasonID
alter table fact_temp add seasonID number;
select * from fact_temp;

update fact_temp f
set f.seasonID = 1
where to_char(f.a_endtime,'MM') in ('09','10','11');

update fact_temp f
set f.seasonID = 2
where to_char(f.a_endtime,'MM') in ('12','01','02');

update fact_temp f
set f.seasonID = 3
where to_char(f.a_endtime,'MM') in ('03','04','05');

update fact_temp f
set f.seasonID = 4
where to_char(f.a_endtime,'MM') in ('06','07','08');

select * from fact_temp;