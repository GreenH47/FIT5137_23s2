CREATE TABLE user (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(100),
  age INT,
  created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from user;

CREATE DATABASE testdb;
USE testdb;
CREATE TABLE student (
   id INT PRIMARY KEY,
   name VARCHAR(100),
   age INT,
   email VARCHAR(100)
);

INSERT INTO student (id, name, age, email)
VALUES
   (1, 'John Doe', 20, 'john@example.com'),
   (2, 'Jane Smith', 22, 'jane@example.com'),
   (3, 'Sam Johnson', 21, 'sam@example.com');

select * from student;

CREATE TABLE bill (
   id INT AUTO_INCREMENT PRIMARY KEY,
   subarea VARCHAR(100),
   electricity FLOAT,
   gas FLOAT,
   carbon FLOAT
);

INSERT INTO bill (subarea, electricity, gas, carbon)
VALUES
   ('Subarea 1', 50.2, 25.5, 10.1),
   ('Subarea 2', 40.1, 20.3, 8.2),
   ('Subarea 3', 35.7, 18.9, 7.5);

select * from bill;


CREATE USER 'yuntao'@'ftp9.clx2a8hznypy.us-east-1.rds.amazonaws.com' IDENTIFIED BY 'MzA4NDA0MDNjNjkxOTVi';
