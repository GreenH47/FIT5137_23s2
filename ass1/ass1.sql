
-- Course
CREATE TABLE course AS
SELECT * FROM MonChild.course;

select * from course

-- Training
CREATE TABLE training AS
SELECT * FROM MonChild.training;
select * from training

-- Teacher
CREATE TABLE teacher AS
SELECT * FROM MonChild.teacher;
select * from teacher

-- Children_Incidents
CREATE TABLE children_incidents AS
SELECT * FROM MonChild.children_incidents;
select * from children_incidents

-- IncidentsType
CREATE TABLE incidentstype AS
SELECT * FROM MonChild.incidentstype;
select * from incidentstype

-- Children
CREATE TABLE children AS
SELECT * FROM MonChild.children;
select * from children

-- Daycare_Center
CREATE TABLE daycare_center AS
SELECT * FROM MonChild.daycare_center;
select * from daycare_center

-- Parents
CREATE TABLE parents AS
SELECT * FROM MonChild.parents;
select * from parents


-- Create Dim_Incident_Type
CREATE TABLE Dim_Incident_Type AS
SELECT * FROM incidentstype;

-- Create Dim_Month
CREATE TABLE Dim_Month AS
SELECT DISTINCT EXTRACT(MONTH FROM INCIDENT_DATE) AS MONTH_ID,
                TO_CHAR(INCIDENT_DATE, 'MON') AS MONTH_NAME
FROM children_incidents;

-- Create Dim_Daycare_Center
CREATE TABLE Dim_Daycare_Center AS
SELECT * FROM daycare_center;

-- Create Dim_Teacher
CREATE TABLE Dim_Teacher AS
SELECT * FROM teacher;

-- Create Dim_Age_Group
CREATE TABLE Dim_Age_Group AS
SELECT CASE
           WHEN CHILD_AGE BETWEEN 1 AND 2 THEN 'Pre-Kinder'
           WHEN CHILD_AGE BETWEEN 3 AND 5 THEN 'Kinder'
           ELSE 'Unknown'
       END AS AGE_GROUP_NAME,
       CASE
           WHEN CHILD_AGE BETWEEN 1 AND 2 THEN 'Pre-Kinder'
           WHEN CHILD_AGE BETWEEN 3 AND 5 THEN 'Kinder'
           ELSE 'Unknown'
       END AS AGE_GROUP_ID
FROM children;

-- Create Fact_Incidents
CREATE TABLE Fact_Incidents AS
SELECT INCIDENTID, INCIDENT_DATE, CHILDRENID, TYPEID, TEACHERID, INCIDENTS_COST,
       EXTRACT(MONTH FROM INCIDENT_DATE) AS INCIDENT_MONTH_ID, CENTERID,
       CASE
           WHEN CHILD_AGE BETWEEN 1 AND 2 THEN 'Pre-Kinder'
           WHEN CHILD_AGE BETWEEN 3 AND 5 THEN 'Kinder'
           ELSE 'Unknown'
       END AS AGE_GROUP_ID
FROM children_incidents;

-- Alter Fact_Incidents to add Foreign Keys
ALTER TABLE Fact_Incidents
ADD CONSTRAINT FK_Dim_Incident_Type
    FOREIGN KEY (TYPEID) REFERENCES Dim_Incident_Type(TYPEID);

ALTER TABLE Fact_Incidents
ADD CONSTRAINT FK_Dim_Month
    FOREIGN KEY (INCIDENT_MONTH_ID) REFERENCES Dim_Month(MONTH_ID);

ALTER TABLE Fact_Incidents
ADD CONSTRAINT FK_Dim_Daycare_Center
    FOREIGN KEY (CENTERID) REFERENCES Dim_Daycare_Center(CENTERID);

ALTER TABLE Fact_Incidents
ADD CONSTRAINT FK_Dim_Teacher
    FOREIGN KEY (TEACHERID) REFERENCES Dim_Teacher(TEACHERID);

ALTER TABLE Fact_Incidents
ADD CONSTRAINT FK_Dim_Age_Group
    FOREIGN KEY (AGE_GROUP_ID) REFERENCES Dim_Age_Group(AGE_GROUP_ID);
