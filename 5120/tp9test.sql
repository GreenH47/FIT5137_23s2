BEGIN TRANSACTION;

--crear student table
CREATE TABLE student (
    id INT identity(1,1) PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    city VARCHAR(255)
);
BEGIN TRANSACTION;
CREATE TABLE teacher (
    id INT identity(1,1) PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    city VARCHAR(255)
);
commit;

--

