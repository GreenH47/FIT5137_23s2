select * from LAB;

-- Agent Dimension
create table AgentDim as
select * from opdb.Agent;
select * from AgentDim;

--Country Dimension
create table CountryDim as
select distinct Country
from opdb.Student;
select * from CountryDim;

--Course Dimension
create table CourseDim as
select CourseCode, CourseName, Duration, CourseLevel
from opdb.Course;
select * from CourseDim;

--Year Dimension
create table YearDim as
select distinct EnrolmentYear
from opdb.Enrolment;
select * from YearDim;

--Fact Table
create table CollegeFact as
select
S.Country,
E.AgentNo,
E.CourseCode,
E.EnrolmentYear,
count(distinct S.StudentID) as Number_of_Students,
sum(P.Amount) as Total_Income
from opdb.Student S, opdb.Enrolment E, opdb.Payment P
where E.EnrolmentNo = P.EnrolmentNo
and E.StudentID = S.StudentID
group by
S.Country,
E.AgentNo,
E.CourseCode,
E.EnrolmentYear;
select * from CollegeFact;

--Show the total number of students enrolled in different years
select EnrolmentYear, sum(Number_of_Students) as Total_Students
from CollegeFact
group by EnrolmentYear;

--How many students come from Australia?
select Country, sum(Number_of_Students) as Total_Students
from CollegeFact
group by Country;

--What is the total income for the Master of Data Science course(C6003) in 2019?
select sum(Total_Income) as Total_Income
from CollegeFact
where CourseCode = 'C6003'

--How many students are handled by New Star Agent?
/*
AgentDim
AgentNo
AgentName
AgentAddress
AgentPhone
ContactPerson
*/
SELECT AD.AgentName, COUNT(DISTINCT CF.Number_of_Students) AS Total_Students
FROM CollegeFact CF
JOIN AgentDim AD ON CF.AgentNo = AD.AgentNo
GROUP BY AD.AgentName;

--How does the number of students in courses fluctuate across the year?
SELECT YD.EnrolmentYear, CD.CourseName, SUM(CF.Number_of_Students) AS Total_Students
FROM CollegeFact CF
JOIN YearDim YD ON CF.EnrolmentYear = YD.EnrolmentYear
JOIN CourseDim CD ON CF.CourseCode = CD.CourseCode
GROUP BY YD.EnrolmentYear, CD.CourseName
ORDER BY YD.EnrolmentYear, CD.CourseName;
