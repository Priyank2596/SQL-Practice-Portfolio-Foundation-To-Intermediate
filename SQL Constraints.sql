/* IN SQL LEARNING - CONSTRAINTS */


/* CONSTRAINTS - NOT NULL */

CREATE TABLE Constraints(
ID INT NOT NULL,NAME VARCHAR(100) NOT NULL,AMOUNT INT NOT NULL)

SELECT *
FROM Constraints

INSERT INTO Constraints (ID,NAME,AMOUNT)
VALUES (1001,'Priyank',5000)

INSERT INTO Constraints (ID,NAME,AMOUNT)
VALUES (1002,'Shivani',NULL)

ALTER TABLE Constraints
ALTER COLUMN NAME VARCHAR(100)

SELECT *
FROM Constraints

INSERT INTO Constraints
VALUES (1003,NULL,6000)

DROP TABLE Constraints


/* CONSTRAINTS - UNIQUE */

CREATE TABLE Constraints(
ID INT UNIQUE, NAME VARCHAR(100) UNIQUE , AMOUNT INT UNIQUE) 

SELECT *
FROM Constraints

--when follow rule
INSERT INTO Constraints
VALUES (1000,'Priyank',2000),
(1001,'Shivani',3000)

--when do not follow rule (text,number)
INSERT INTO Constraints
VALUES (1002,'Janhavi',3000),
(1003,'Janhavi',4000)

--when do not follow rule (null)
INSERT INTO Constraints (ID,NAME,AMOUNT)
VALUES (1004,'Namrita',NULL),
(1005,'Kanchan',NULL)
(



