use council;

CREATE TABLE Bin (
  council_name VARCHAR(500),
  landfill_yes VARCHAR(500),
  landfill_no VARCHAR(500),
  recycle_yes VARCHAR(500),
  recycle_no VARCHAR(500),
  green_yes VARCHAR(500),
  green_no VARCHAR(500)
);

select * from Bin;

TRUNCATE TABLE Bin;








-- select postcode and their policy
select p.council_name,p.postcode,b.green_yes,b.green_no
from Bin b, Postcode p
where b.council_name = p.council_name
-- and b.council_name = 'Ballarat City Council'
and p.postcode = 3352
group by b.council_name,p.postcode,b.green_yes,b.green_no
order by b.council_name,p.postcode,b.green_yes,b.green_no;


-- s
SELECT p.council_name, p.postcode
FROM Bin b
JOIN Postcode p ON b.council_name = p.council_name
GROUP BY p.council_name, p.postcode
ORDER BY p.council_name, p.postcode;


-- select postcode and their policy
select p.council_name,p.postcode,b.landfill_no,b.landfill_yes,b.recycle_no,b.recycle_yes,b.green_no,b.green_yes
from Bin b, Postcode p
where b.council_name = p.council_name
and p.postcode = 3352
group by b.council_name,p.postcode,b.landfill_no,b.landfill_yes,b.recycle_no,b.recycle_yes,b.green_no,b.green_yes
limit 1;


-- select how many postcode linked to each council
select b.council_name,p.postcode
from Bin b, Postcode p
where b.council_name = p.council_name
group by p.postcode
order by p.postcode;
