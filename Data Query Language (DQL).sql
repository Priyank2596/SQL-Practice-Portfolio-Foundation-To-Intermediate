/* BARREN YOUTUBE LEARNING - MAKING PRATICAL NOTES*/

--LEARNING ABOUT THE QUERY--

--1) SELECT 

-- A) WHEN YOU HAVE TO SELCET\SEE WHOLE DATA 

SELECT*
FROM customers
-- B) WHEN YOU HAVE TO SELECT SPECIFIC PART
   
SELECT
first_name, score
FROM customers



--2) WHERE (Condition)

-- A) WHEN YOU PUT CONDITION AND WANT FULL ROW

SELECT*
FROM customers
WHERE country= 'Germany'

SELECT*
FROM customers
WHERE score != 0
-- B) WHEN YOU PUT CONDITION AND WANT SPECIFIC COLUMN 

SELECT
country,score
FROM customers
WHERE score=500


-- 3) ORDER BY (Sorting) 

-- A) DECENDING ORDER (When you want data in descending order)

SELECT*
FROM customers
ORDER BY score DESC
-- B) ASCENDING ORDER (When you want data in ascending order)

SELECT*
FROM customers
ORDER BY score ASC


-- C) ORDER BY (Nested form)  

SELECT*
FROM customers
ORDER BY country ASC ,score DESC



-- 4) GROUP BY (AGGREGATE FORM)

-- Find the Total Score for each Country

 SELECT
 country,
 SUM(score)
 FROM customers
 GROUP BY country

 --Find the Total Score for each Country and also give table name after aggregation


 SELECT
 country,
 SUM(score) AS total_score
 FROM customers
 GROUP BY country

--IT IS COMPLUSORY THAT THE NON-AGGREGATED COLUMN THAT YOU ARE ADDING IN THE SELECT MUST BE AS WELL AS MENTIONED IN THE GROUP BY


SELECT
country,
first_name,
SUM(score)
FROM customers
GROUP BY country, first_name

--Find the Total score and Total number of customers for each country

SELECT 
country,
SUM(score) AS total_score,
COUNT(id) AS total_count
FROM customers
GROUP BY country

--5) HAVING 
--A) USING OF HAVING IN NORMAL FORM

SELECT
country,
SUM(score) AS total_score,
COUNT(id)
FROM customers
GROUP BY country
HAVING SUM(score)>750

--B) COMBINE (Where+Having)

SELECT 
country,
AVG(score) AS avg_score
FROM customers
WHERE score!=0
GROUP BY country
HAVING AVG(score)>430

--6) DISTINCT (FOR UNIQUE VALUES)

SELECT DISTINCT 
country,
FROM customers

--7) TOP (LIMIT YOUR DATA)

--A)RETRIEVE ONLY 3 CUSTOMERS

SELECT TOP 3 *
FROM customers

--B)RETRIEVE THE TOP 3 CUSTOMERS WITH THE HIGHEST SCORES

SELECT TOP 3*
FROM customers 
ORDER BY score DESC

--C)RETRIEVE THE LOWEST 2 CUSTOMERS BASED ON THE SCORES

SELECT TOP 2*
FROM customers
ORDER BY score ASC

--D)GET THE TWO MOST RECENT ORDERS

SELECT TOP 2*
FROM orders
ORDER BY order_date DESC

--8)MULTIPLE QUERIES ONE AT A TIME

SELECT*
FROM orders

SELECT*
FROM customers

--9) STATIC (FIX) VALUES

--A) FOR NUMBERS 
SELECT 1234 AS static_number

--B) FOR TEXT
SELECT 'PRIYANK' AS static_text

--C)INSERT IN EXISTING DATA 

SELECT
id,
first_name,
'New Customer' AS customer_type
FROM customers




















