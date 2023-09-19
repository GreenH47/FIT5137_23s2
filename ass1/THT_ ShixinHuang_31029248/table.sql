/*
THT 31029248 2023-08-12
I already copy all the tables from the MonChild account.
So in all the queries below, I don’t need the prefix for all the tables.
Please execute those parts in my SQL script before
creating any the dim and fact tables.

COPY ALL TABLE FROM MONCHILD
*/
-- Course
CREATE TABLE course AS
SELECT * FROM MonChild.course;

select * from course;

-- Training
CREATE TABLE training AS
SELECT * FROM MonChild.training;
select * from training;

-- Teacher
CREATE TABLE teacher AS
SELECT * FROM MonChild.teacher;
select * from teacher;

-- Children_Incidents
CREATE TABLE children_incidents AS
SELECT * FROM MonChild.children_incidents;
select * from children_incidents;

-- IncidentsType
CREATE TABLE incidentstype AS
SELECT * FROM MonChild.incidentstype;
select * from incidentstype;

-- Children
CREATE TABLE children AS
SELECT * FROM MonChild.children;
select * from children;

-- Daycare_Center
CREATE TABLE daycare_center AS
SELECT * FROM MonChild.daycare_center;
select * from daycare_center;

-- Parents
CREATE TABLE parents AS
SELECT * FROM MonChild.parents;
select * from parents;


-- Create Dim_Incident_Type
CREATE TABLE Dim_Incident_Type AS
SELECT * FROM incidentstype;
select * from Dim_Incident_Type;


/*
CREATE THE DATA WAREHOUSE
*/

-- Create Dim_Month
CREATE TABLE Dim_Month AS
SELECT DISTINCT EXTRACT(MONTH FROM ci.INCIDENT_DATE) AS MONTH_ID,
                TO_CHAR(ci.INCIDENT_DATE, 'MON') AS MONTH_NAME
FROM children_incidents ci;
select * from Dim_Month;

-- Create Dim_Daycare_Center
CREATE TABLE Dim_Daycare_Center AS
SELECT * FROM daycare_center;
select * from Dim_Daycare_Center;

-- Create Dim_Teacher
CREATE TABLE Dim_Teacher AS
SELECT * FROM teacher;
select * from Dim_Teacher;

-- Create Dim_Age_Group
-- Create Age_Group reference table
CREATE TABLE Dim_Age_Group (
  AGE_GROUP_ID NUMBER PRIMARY KEY,
  AGE_GROUP_NAME VARCHAR2(20) NOT NULL
);

-- Insert Age_Group dimension values
INSERT INTO Dim_Age_Group (AGE_GROUP_ID, AGE_GROUP_NAME)
VALUES (1, 'Pre-Kinder');

INSERT INTO Dim_Age_Group (AGE_GROUP_ID, AGE_GROUP_NAME)
VALUES (2, 'Kinder');

select * from Dim_Age_Group;


-- create fact test table
CREATE TABLE fact_test AS
select ci.INCIDENTID,
       ci.INCIDENTS_COST,
       ci.TYPEID,
       ci.TEACHERID,
       dc.CENTERID,
       c.CHILD_AGE,
       EXTRACT(MONTH FROM ci.INCIDENT_DATE) AS MONTH_ID
from children_incidents ci
         join children c on ci.CHILDRENID = c.CHILDRENID
         join daycare_center dc on c.CENTERID = dc.CENTERID;

select * from fact_test;

-- Alter Fact_Test table to add AGE_GROUP_ID
ALTER TABLE fact_test
ADD AGE_GROUP_ID NUMBER;

-- Update AGE_GROUP_ID based on CHILD_AGE
UPDATE fact_test
SET AGE_GROUP_ID = CASE
                        WHEN CHILD_AGE BETWEEN 1 AND 2 THEN 1
                        WHEN CHILD_AGE BETWEEN 3 AND 5 THEN 2
                   END;

select * from fact_test;

-- create Fact_Incidents table from fact_test
CREATE TABLE Fact_Incidents AS
select
    month_id,
    TYPEID,
    AGE_GROUP_ID,
    TEACHERID,
    CENTERID,
    count(INCIDENTID) AS INCIDENTS_COUNT,
    SUM(INCIDENTS_COST) AS INCIDENTS_COST

from fact_test

group by
    month_id,
    TYPEID,
    AGE_GROUP_ID,
    TEACHERID,
    CENTERID;

select * from Fact_Incidents;

