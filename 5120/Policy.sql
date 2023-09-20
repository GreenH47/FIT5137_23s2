use council;

drop table Policy;


CREATE TABLE Policy (
  waste_type VARCHAR(255),
  council_name VARCHAR(255),
  waste_policy VARCHAR(255)
);

select * from Policy;


select c.postcode, p.council_name,p.waste_type, p.waste_policy
from Policy p,Postcode c
where p.council_name = c.council_name
and c.postcode = '3352';

select distinct Policy.council_name
from Policy;


select *
from Postcode
where council_name = 'Alpine Council';

-- check how many postcode related with policy
SELECT p.council_name,c.postcode
FROM Policy p
JOIN Postcode c ON p.council_name = c.council_name
GROUP BY p.council_name,c.postcode

