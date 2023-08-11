Create Table SUBJECT
As Select *
From dtaniar.SUBJECT;

-- Copy LECTURE table
CREATE TABLE LECTURE AS
SELECT * FROM dtaniar.LECTURE;

-- Copy TUTOR table
CREATE TABLE TUTOR AS
SELECT * FROM dtaniar.TUTOR;

-- Copy LAB table
CREATE TABLE LAB AS
SELECT * FROM dtaniar.LAB;

-- Copy STUDENT_ENROLMENT table
CREATE TABLE STUDENT_ENROLMENT AS
SELECT * FROM dtaniar.STUDENT_ENROLMENT;

-- Copy LAB_SIGNUP table
CREATE TABLE LAB_SIGNUP AS
SELECT * FROM dtaniar.LAB_SIGNUP;

commit;

--Write an SQL statement to list all the lecturers and their lecture schedules
SELECT L.*, LE.*
FROM LECTURER L
JOIN LECTURE LE ON L.STAFFNO = LE.STAFFNO;

-- Are there any lecturers who are not teaching?
SELECT L.*
FROM LECTURER L
LEFT JOIN LECTURE LE ON L.STAFFNO = LE.STAFFNO
WHERE LE.STAFFNO IS NULL;


select * from TAB;