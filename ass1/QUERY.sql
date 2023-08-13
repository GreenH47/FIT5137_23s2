
/*
query part
*/
-- A. Show the total number of incidents and total incident costs by age group
select
    AGE_GROUP_NAME,
    SUM(INCIDENTS_COUNT) AS TOTAL_INCIDENTS_COUNT,
    SUM(INCIDENTS_COST) AS TOTAL_INCIDENTS_COST
from Fact_Incidents fi
         join Dim_Age_Group dag on fi.AGE_GROUP_ID = dag.AGE_GROUP_ID
group by AGE_GROUP_NAME;

--Show the total number of incidents and total incident costs
-- for the teachers whose roles are Early childhood teacher.
select
    t.TEACHER_NAME,
    SUM(INCIDENTS_COUNT) AS TOTAL_INCIDENTS_COUNT,
    SUM(INCIDENTS_COST) AS TOTAL_INCIDENTS_COST
from Fact_Incidents fi
         join Dim_Teacher t on fi.TEACHERID = t.TEACHERID
where t.TEACHER_ROLE = 'Early childhood teacher'
group by t.TEACHER_NAME;

--Show the total number of incidents and total incident costs by incident type in May.
SELECT it.TYPEID,
       SUM(INCIDENTS_COUNT) AS TOTAL_INCIDENTS_COUNT,
       SUM(INCIDENTS_COST) AS TOTAL_INCIDENTS_COST
FROM Fact_Incidents fi
JOIN Dim_Incident_Type it ON fi.TYPEID = it.TYPEID
JOIN Dim_Month dm ON fi.MONTH_ID = dm.MONTH_ID
where dm.MONTH_NAME = 'MAY'
GROUP BY it.TYPEID
order by TYPEID asc;


--Show the total number of incidents and total incident costs by daycare center.
select
    dc.CENTERID,
    SUM(INCIDENTS_COUNT) AS TOTAL_INCIDENTS_COUNT,
    SUM(INCIDENTS_COST) AS TOTAL_INCIDENTS_COST
from Fact_Incidents fi
         join Dim_Daycare_Center dc on fi.CENTERID = dc.CENTERID
group by dc.CENTERID
order by CENTERID ASC;

--Show all information about the teacher who has the lowest number of incidents,
-- including:teacherID,teacher_role,teacher_name,total_num_incident,total_incidentCost
select
    t.TEACHERID,
    t.TEACHER_ROLE,
    t.TEACHER_NAME,
    SUM(INCIDENTS_COUNT) AS TOTAL_NUM_INCIDENTS,
    SUM(INCIDENTS_COST) AS TOTAL_INCIDENTCOST
from Fact_Incidents fi
         join Dim_Teacher t on fi.TEACHERID = t.TEACHERID
group by t.TEACHERID, t.TEACHER_ROLE, t.TEACHER_NAME
order by TEACHER_NAME ASC;

