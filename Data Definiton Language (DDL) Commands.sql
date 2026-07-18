
/* CREATING THE TABLE STRUCTURE */

--1) CREATE

CREATE TABLE Persons(
id INT NOT NULL,
person_name VARCHAR(100) NOT NULL,
birth_date DATE,
phone VARCHAR(100) NOT NULL
CONSTRAINT pk_person PRIMARY KEY (id))

SELECT*
FROM Persons

--2) ALTER
--A) ADD COLUMN 

ALTER TABLE Persons 
ADD email VARCHAR(100) NOT NULL

SELECT*
FROM Persons

--B) DROP COLUMN 

ALTER TABLE persons 
DROP COLUMN phone 

SELECT*
FROM Persons

--3) DROP TABLE

DROP TABLE Persons




