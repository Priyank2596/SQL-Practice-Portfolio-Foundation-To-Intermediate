
/* DATA MANIPULATION LANGUAGE - NOTES/PRATICE PART */

--1) INSERT

--I) MANUAL ENTRY (VALUES)

--A) FILL ALL ROWS

INSERT INTO customers (id,first_name,country,score)
VALUES (6,'Anna', 'USA',NULL),
(7,'Sam', NULL, 100)

--B) FILL SELECTED ROWS

INSERT INTO customers (id, first_name)
VALUES (8,'Sahra')

SELECT*
FROM customers

--II) COPY FORM SOURCE TABLE

--A) COPY

INSERT INTO Persons   
SELECT
id,
first_name,
NULL,
'UNKNOWN'
FROM customers

SELECT*
FROM Persons


--2) UPDATE
--A)CHANGE IN CELL  (CHANGE THE SCORE OF THE CUSTOMER WITH ID 6 TO 0)

SELECT*
FROM customers

UPDATE customers
SET score=0
WHERE id=6

--B)CHANGE IN ROW  (CHANGE THE SCORE OF CUSTOMERS WITH ID 8 TO 0 AND UPDATE THE COUNTRY TO 'UK')

SELECT*
FROM customers

UPDATE customers
SET score=0,
country='UK'
WHERE id=8

--C)MULTIPLE QUERY IN ONCE/NULL HANDLING  (UPDATE ALL CUSTOMERS WITH 0 A SCORE BY SETTING THEIR SCORE TO NULL)

SELECT*
FROM customers
WHERE score=0

UPDATE customers
SET score=NULL
WHERE score=0

SELECT*
FROM customers

--3) DELETE 
--A) DELETE MULTIPLE ROWS AT ONCE 

SELECT*
FROM customers
WHERE id>5

DELETE customers
WHERE id>5

SELECT*
FROM customers














