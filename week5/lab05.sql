select * from FACT_AUCTION;

select * from "Covid";

ALTER TABLE "Covid"
RENAME TO Covid;

ALTER TABLE Covid
RENAME COLUMN "Singapore_Cumulative Case" TO Singapore_Cumulative_Case;

ALTER TABLE Covid
RENAME COLUMN "Singapore_Cumulative Death" TO Singapore_Cumulative_Death;

ALTER TABLE Covid
RENAME COLUMN "Date" TO Covid_Date;

ALTER TABLE Covid
RENAME COLUMN "Singapore_DailyCase" TO Singapore_DailyCase;

ALTER TABLE Covid
RENAME COLUMN "Singapore_DailyDeath" TO Singapore_DailyDeath;

ALTER TABLE Covid
RENAME COLUMN "Singapore_Vaccine" TO Singapore_Vaccine;

ALTER TABLE Covid
RENAME COLUMN "Singapore_DailyVaccine" TO Singapore_DailyVaccine;

ALTER TABLE Covid
RENAME COLUMN "Singapore_Moving_ave_DailyPostive7" TO Singapore_Moving_ave_DailyPostive7;

ALTER TABLE Covid
RENAME COLUMN "Singapore_Moving_ave_DailyDeath7" TO Singapore_Moving_ave_DailyDeath7;

ALTER TABLE Covid
RENAME COLUMN "Singapore_Moving_ave_DailVaccine7" TO Singapore_Moving_ave_DailVaccine7;

select * from Covid;


-- check if covid_date contains null value
DELETE FROM Covid WHERE covid_date IS NULL;

-- convert covid_date to date type
ALTER TABLE Covid ADD (covid_date_new DATE);
UPDATE Covid SET covid_date_new = TO_DATE(covid_date, 'MM/DD/YYYY');
ALTER TABLE Covid DROP COLUMN covid_date;
ALTER TABLE Covid RENAME COLUMN covid_date_new TO covid_date;

-- check if covid_date column is unique

SELECT covid_date
FROM Covid
GROUP BY covid_date
HAVING COUNT(*) > 1;



-- 1. Find the total cumulative cases and deaths in Singapore
SELECT SUM(Singapore_Cumulative_Case)  AS Total_Cumulative_Case,
       SUM(Singapore_Cumulative_Death) AS Total_Cumulative_Death
FROM Covid;

-- . Find the date with the highest number of daily cases in Singapore
SELECT
    Singapore_DailyCase,
    covid_date
FROM Covid
WHERE Singapore_DailyCase = (SELECT MAX(Singapore_DailyCase) FROM Covid);

SELECT
    Singapore_DailyCase,
    covid_date
FROM Covid
order by
Singapore_DailyCase desc;

-- Calculate the average daily cases and deaths in Singapore
SELECT AVG(Singapore_DailyCase) AS Average_Daily_Case,
       AVG(Singapore_DailyDeath) AS Average_Daily_Death
FROM Covid;

-- Find the date with the highest number of daily vaccine doses administered in
-- Singapore
SELECT
    Singapore_DailyVaccine,
    covid_date
FROM Covid
WHERE Singapore_DailyVaccine = (SELECT MAX(Singapore_DailyVaccine) FROM Covid);

-- Calculate the the average number of
-- 7-day moving average of daily positive cases, daily deaths, and daily vaccine doses
-- in Singapore
SELECT
    AVG(Singapore_Moving_ave_DailyPostive7) AS Average_7_day_moving_ave_DailyPostive,
    AVG(Singapore_Moving_ave_DailyDeath7) AS Average_7_day_moving_ave_DailyDeath,
    AVG(Singapore_Moving_ave_DailVaccine7) AS Average_7_day_moving_ave_DailVaccine
FROM Covid;
