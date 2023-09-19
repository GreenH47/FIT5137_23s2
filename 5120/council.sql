CREATE DATABASE council;

USE council;
SHOW DATABASES;

drop table Waste;
drop table Council;
drop table Year;

CREATE TABLE Year (
  year INT PRIMARY KEY
);



CREATE TABLE Council (
  council_id INT AUTO_INCREMENT PRIMARY KEY,
  council_name VARCHAR(255)
);


CREATE TABLE Waste (
  year INT,
  council_id INT,
  waste_pp FLOAT,
  garbage_pp FLOAT,
  recycle_pp FLOAT,
  organic_pp FLOAT,
  collect_type VARCHAR(255),
  amount INT,
  diversion_rate FLOAT,
  FOREIGN KEY (year) REFERENCES Year(year),
  FOREIGN KEY (council_id) REFERENCES Council(council_id)
);

select * from Council;

INSERT INTO Year (year)
SELECT DISTINCT year
FROM waste_final;



INSERT INTO Council (council_name)
SELECT DISTINCT council
FROM waste_final;


INSERT INTO Waste (year, council_id, waste_pp, garbage_pp, recycle_pp, organic_pp, collect_type, amount, diversion_rate)
SELECT wf.year, c.council_id, wf.waste_pp, wf.garbage_pp, wf.recycle_pp, wf.organic_pp, wf.collect_type, wf.amount, wf.diversion_rate
FROM waste_final wf
JOIN Council c ON wf.council = c.council_name
JOIN Year y ON wf.year = y.year;

-- count the number of rows in Waste table
SELECT COUNT(*) FROM Waste;
SELECT COUNT(*) FROM waste_final;


-- select council_name ='Knox City Council' data from Waste table
SELECT * FROM Waste
JOIN Council c ON c.council_id = Waste.council_id
WHERE c.council_name = 'Knox City Council';

-- check how many unqiue council_name in Waste table
SELECT DISTINCT council_name FROM Waste
JOIN Council c ON c.council_id = Waste.council_id;
