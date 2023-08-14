-- Show the total number of incidents and total incident costs by month_id
SELECT MONTH_ID,
       SUM(INCIDENTS_COUNT) AS INCIDENTS_COUNT,
       SUM(INCIDENTS_COST) AS INCIDENTS_COST
FROM Fact_Incidents
GROUP BY MONTH_ID
ORDER BY MONTH_ID asc;

-- Show the total number of incidents and total incident costs by typeid
SELECT TYPEID,
       SUM(INCIDENTS_COUNT) AS INCIDENTS_COUNT,
       SUM(INCIDENTS_COST) AS INCIDENTS_COST
FROM Fact_Incidents
GROUP BY TYPEID
ORDER BY TYPEID asc;

-- Show the total number of incidents and total incident costs by TEACHERID with full teacher details
SELECT t.TEACHERID,
       t.TEACHER_NAME,
       SUM(INCIDENTS_COUNT) AS INCIDENTS_COUNT,
       SUM(INCIDENTS_COST) AS INCIDENTS_COST
FROM Fact_Incidents fi
         JOIN Dim_Teacher t ON fi.TEACHERID = t.TEACHERID
GROUP BY t.TEACHERID, t.TEACHER_NAME
ORDER BY t.TEACHERID asc;

-- Show the total number of incidents and total incident costs by CENTERID
SELECT CENTERID,
       SUM(INCIDENTS_COUNT) AS INCIDENTS_COUNT,
       SUM(INCIDENTS_COST) AS INCIDENTS_COST
FROM Fact_Incidents
GROUP BY CENTERID
ORDER BY CENTERID asc;

-- A. Show the total number of incidents and total incident costs by age group
select
    AGE_GROUP_NAME,
    SUM(INCIDENTS_COUNT) AS TOTAL_INCIDENTS_COUNT,
    SUM(INCIDENTS_COST) AS TOTAL_INCIDENTS_COST
from Fact_Incidents fi
         join Dim_Age_Group dag on fi.AGE_GROUP_ID = dag.AGE_GROUP_ID
group by AGE_GROUP_NAME
order by AGE_GROUP_NAME asc;