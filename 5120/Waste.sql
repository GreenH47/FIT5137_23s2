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

CREATE TABLE Waste_policy AS
SELECT w.year, c.council_name, w.waste_pp, w.garbage_pp, w.recycle_pp, w.organic_pp, w.collect_type, w.amount, w.diversion_rate
FROM Waste w
JOIN Council c ON w.council_id = c.council_id


select * from Waste_policy;

ALTER TABLE Postcode
ADD INDEX IDX_Postcode_council_name (council_name);


ALTER TABLE Bin ADD COLUMN council_name_fk VARCHAR(255);
UPDATE Bin SET council_name_fk = council_name WHERE council_name IN (SELECT council_name FROM Postcode);


ALTER TABLE Bin ADD CONSTRAINT FK_Bin_Postcode FOREIGN KEY (council_name_fk) REFERENCES Postcode (council_name);
