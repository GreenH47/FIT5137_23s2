use council;

drop table Postcode;

CREATE TABLE Postcode (
    locality_name VARCHAR(255),
    postcode INT,
    council_name VARCHAR(255)
);

select * from Postcode;



-- check if there is any duplicate value with same locality_name,postcode,council_name
SELECT locality_name, postcode, council_name, COUNT(*)
FROM Postcode
GROUP BY locality_name, postcode, council_name
HAVING COUNT(*) > 1;


select postcode,count(*)
from Postcode
group by postcode
having count(*) > 1;


select * from Postcode;

-- join Council and Postcode table select Alpine Shire Council
-- with all postcodes with council_id
SELECT Council.council_name, Postcode.postcode, Postcode.locality_name, Council.council_id
FROM Council,Postcode
WHERE Council.council_name = Postcode.council_name
AND Council.council_name = 'Boroondara City Council'
ORDER BY Postcode.postcode;

select * from Postcode;

