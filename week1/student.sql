CREATE TABLE STUDENT (
    StudentNO NUMBER(6) NOT NULL,
    DOB DATE,
    FName VARCHAR2(30),
    LName VARCHAR2(30),
    -- city spelt CiTTy
    CiTTy VARCHAR2(40),
    PostCode VARCHAR2(4),
    Country VARCHAR2(30),
    FeePaid NUMBER(8,2),
    LastFeeDate DATE,
    PRIMARY KEY(StudentNo)
);


-- Inserting Student 1
INSERT INTO STUDENT (StudentNO, DOB, FName, LName, CiTTy, PostCode, Country, FeePaid, LastFeeDate)
VALUES (30001, TO_DATE('12-FEB-2002', 'DD-MON-YYYY'), 'John', 'Doe', 'Melbourne', '3000', 'Australia', 5000.00, TO_DATE('01-JAN-2022', 'DD-MON-YYYY'));

-- Inserting Student 2
INSERT INTO STUDENT (StudentNO, DOB, FName, LName, CiTTy, PostCode, Country, FeePaid, LastFeeDate)
VALUES (30002, TO_DATE('12-FEB-2002', 'DD-MON-YYYY'), 'Jane', 'Smith', 'Sydney', '2000', 'Australia', 6000.00, TO_DATE('01-JAN-2022', 'DD-MON-YYYY'));

-- Inserting Student 3
INSERT INTO STUDENT (StudentNO, DOB, FName, LName, CiTTy, PostCode, Country, FeePaid, LastFeeDate)
VALUES (30003, TO_DATE('12-FEB-2002', 'DD-MON-YYYY'), 'Michael', 'Johnson', 'Brisbane', '4000', 'Australia', 5500.00, TO_DATE('01-JAN-2022', 'DD-MON-YYYY'));

-- Inserting Student 4
INSERT INTO STUDENT (StudentNO, DOB, FName, LName, CiTTy, PostCode, Country, FeePaid, LastFeeDate)
VALUES (30004, TO_DATE('12-FEB-2002', 'DD-MON-YYYY'), 'Emily', 'Wilson', 'Perth', '6000', 'Australia', 5200.00, TO_DATE('01-JAN-2022', 'DD-MON-YYYY'));

-- Inserting Student 5
INSERT INTO STUDENT (StudentNO, DOB, FName, LName, CiTTy, PostCode, Country, FeePaid, LastFeeDate)
VALUES (30005, TO_DATE('12-FEB-2002', 'DD-MON-YYYY'), 'Robert', 'Lee', 'Adelaide', '5000', 'Australia', 5400.00, TO_DATE('01-JAN-2022', 'DD-MON-YYYY'));


SELECT * FROM STUDENT;

commit;

ALTER TABLE STUDENT
ADD (
    StreetAddress VARCHAR2(70), -- New column to store the street address of the student
    Suburb VARCHAR2(40) -- New column to store the suburb or locality information
);

-- Alter the STUDENT table to drop the CiTTy column
ALTER TABLE STUDENT
DROP COLUMN CiTTy;

UPDATE STUDENT
SET StreetAddress = '12 New St'
WHERE StudentNo = 30001;

commit;