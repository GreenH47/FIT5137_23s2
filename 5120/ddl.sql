create table Bin
(
    council_name varchar(500) null,
    landfill_yes varchar(500) null,
    landfill_no  varchar(500) null,
    recycle_yes  varchar(500) null,
    recycle_no   varchar(500) null,
    green_yes    varchar(500) null,
    green_no     varchar(500) null
);

create table Policy
(
    waste_type   varchar(255) null,
    council_name varchar(255) null,
    waste_policy varchar(255) null
);

create table Postcode
(
    locality_name varchar(255) null,
    postcode      int          null,
    council_name  varchar(255) null
);

create index IDX_Postcode_council_name
    on Postcode (council_name);

create table Waste_policy
(
    year           int          null,
    council_name   varchar(255) null,
    waste_pp       float        null,
    garbage_pp     float        null,
    recycle_pp     float        null,
    organic_pp     float        null,
    collect_type   varchar(255) null,
    amount         int          null,
    diversion_rate float        null
);

