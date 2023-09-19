-- Create GlucoseAlbumin table
Create TABLE GlucoseAlbumin
(
Glucose NUMERIC(18,6) NOT NULL,
Albumin NUMERIC(18,6) NOT NULL
);
-- Insert the data
insert into GlucoseAlbumin (Glucose, Albumin) values
(162.2, 3.5);
insert into GlucoseAlbumin (Glucose, Albumin) values
(93.7, 2.9);
insert into GlucoseAlbumin (Glucose, Albumin) values
(68.5, 2.6);
insert into GlucoseAlbumin (Glucose, Albumin) values
(155.0, 3.0);
insert into GlucoseAlbumin (Glucose, Albumin) values
(121.0, 4.5);
insert into GlucoseAlbumin (Glucose, Albumin) values
(198.0, 2.2);
insert into GlucoseAlbumin (Glucose, Albumin) values
(99.1, 4.1);
insert into GlucoseAlbumin (Glucose, Albumin) values
(180.2, 5.0);
insert into GlucoseAlbumin (Glucose, Albumin) values
(169.0, 3.4);
insert into GlucoseAlbumin (Glucose, Albumin) values
(64.9, 2.6);
insert into GlucoseAlbumin (Glucose, Albumin) values
(72.1, 3.9);
insert into GlucoseAlbumin (Glucose, Albumin) values
(155.0, 4.6);
insert into GlucoseAlbumin (Glucose, Albumin) values
(218.0, 3.8);
insert into GlucoseAlbumin (Glucose, Albumin) values
(146.0, 4.5);
insert into GlucoseAlbumin (Glucose, Albumin) values
(91.9, 2.6);
insert into GlucoseAlbumin (Glucose, Albumin) values
(200.0, 4.6);
insert into GlucoseAlbumin (Glucose, Albumin) values
(70.3, 2.0);

select * from GlucoseAlbumin;

--Calculate the slope for Glucose-Albumin.
-- the intercept and slope for the Glucose-Albumin are
-- 2.4959 and 0.0077, respectivel
SELECT (COUNT(*) * SUM(Glucose * Albumin) - SUM(Glucose) * SUM(Albumin)) / (COUNT(*) * SUM(Glucose * Glucose) - SUM(Glucose) * SUM(Glucose)) AS Slope
FROM GlucoseAlbumin;

--Calculate the slope and intercept for Glucose-Albumin
-- Calculate the slope and intercept for Glucose vs Albumin
SELECT
    (COUNT(*) * SUM(Glucose * Albumin) - SUM(Glucose) * SUM(Albumin)) / (COUNT(*) * SUM(Glucose * Glucose) - SUM(Glucose) * SUM(Glucose)) AS Slope,
    (SUM(Albumin) - ((COUNT(*) * SUM(Glucose * Albumin)) - (SUM(Glucose) * SUM(Albumin))) / (COUNT(*) * SUM(Glucose * Glucose) - SUM(Glucose) * SUM(Glucose)) * SUM(Glucose)) / COUNT(*) AS Intercept
FROM GlucoseAlbumin;





-- Create Age WBC table
Create TABLE Age_WBC
(
Age NUMERIC(3,0) NOT NULL,
WBC NUMERIC(18,6) NOT NULL
);

-- Insert the data
insert into Age_WBC (Age, WBC) values (74,27);
insert into Age_WBC (Age, WBC) values (56.3, 8.6);
insert into Age_WBC (Age, WBC) values (55.9, 8.5);
insert into Age_WBC (Age, WBC) values (80.4, 9.2);
insert into Age_WBC (Age, WBC) values (56.8, 7.8);
insert into Age_WBC (Age, WBC) values (29.8, 18.2);
insert into Age_WBC (Age, WBC) values (19.1, 12.2);
insert into Age_WBC (Age, WBC) values (32.7, 19);
insert into Age_WBC (Age, WBC) values (28.3, 37.3);
insert into Age_WBC (Age, WBC) values (73.8, 41.5);
insert into Age_WBC (Age, WBC) values (62.7, 30.2);
insert into Age_WBC (Age, WBC) values (25.7, 16.6);
insert into Age_WBC (Age, WBC) values (66, 17.6);
insert into Age_WBC (Age, WBC) values (64.9, 16);
insert into Age_WBC (Age, WBC) values (37.2, 16.1);
insert into Age_WBC (Age, WBC) values (94.6, 4.7);
insert into Age_WBC (Age, WBC) values (39.7, 8.4);
insert into Age_WBC (Age, WBC) values (29.9, 9.7);
insert into Age_WBC (Age, WBC) values (48, 5.4);
insert into Age_WBC (Age, WBC) values (42, 24.4);
insert into Age_WBC (Age, WBC) values (71.5, 19.5);
insert into Age_WBC (Age, WBC) values (47.4, 18.3);
insert into Age_WBC (Age, WBC) values (24.9, 17.7);
insert into Age_WBC (Age, WBC) values (50.8, 6);
insert into Age_WBC (Age, WBC) values (45.3, 20.9);
insert into Age_WBC (Age, WBC) values (76.7, 2.5);
insert into Age_WBC (Age, WBC) values (55.7, 12.1);
insert into Age_WBC (Age, WBC) values (86.8, 7.3);
insert into Age_WBC (Age, WBC) values (83.5, 8.4);
insert into Age_WBC (Age, WBC) values (84.4, 18);
insert into Age_WBC (Age, WBC) values (18.7, 26);
insert into Age_WBC (Age, WBC) values (85, 9.6);
insert into Age_WBC (Age, WBC) values (57.3, 9.8);
insert into Age_WBC (Age, WBC) values (80.6, 6.9);
insert into Age_WBC (Age, WBC) values (65.8, 23.2);
insert into Age_WBC (Age, WBC) values (67.9, 14.8);
insert into Age_WBC (Age, WBC) values (84.9, 9.2);
insert into Age_WBC (Age, WBC) values (67.1, 6.8);
insert into Age_WBC (Age, WBC) values (51.1, 21.9);
insert into Age_WBC (Age, WBC) values (88.6, 8.4);
insert into Age_WBC (Age, WBC) values (29.8, 10);
insert into Age_WBC (Age, WBC) values (65, 14.9);
insert into Age_WBC (Age, WBC) values (74, 11);
insert into Age_WBC (Age, WBC) values (78.9, 16.7);
insert into Age_WBC (Age, WBC) values (53.4, 6);
insert into Age_WBC (Age, WBC) values (86, 6.5);
insert into Age_WBC (Age, WBC) values (71.8, 14.5);
insert into Age_WBC (Age, WBC) values (54.7, 12.3);
insert into Age_WBC (Age, WBC) values (90.9, 21.9);

select * from Age_WBC;

--The intercept and slope for the Age-WBC are
-- 20.1574 and -0.0919, respectively

-- Calculate the slope and intercept for Age vs WBC
SELECT
    (COUNT(*) * SUM(Age * WBC) - SUM(Age) * SUM(WBC)) / (COUNT(*) * SUM(Age * Age) - SUM(Age) * SUM(Age)) AS Slope,
    (SUM(WBC) - ((COUNT(*) * SUM(Age * WBC)) - (SUM(Age) * SUM(WBC))) / (COUNT(*) * SUM(Age * Age) - SUM(Age) * SUM(Age)) * SUM(Age)) / COUNT(*) AS Intercept
FROM Age_WBC;
