/* COMBINING DATA - LEARN ABOUT JOINS AND SET OPERATORS */

/* LEARNING ABOUT JOIN */

--1) BASICS JOIN

--A) NO JOIN      (RETERIEVE ALL THE DATA FROM customers AND orders AS SEPERATE RESULT)

SELECT*
FROM customers;

SELECT*
FROM orders;

--B) INNER JOIN  (GET ALL CUSTOMERS ALONG WITH THEIR orders, BUT ONLY FOR customers WHO HAVE PLACED AN ORDER) 

SELECT*
FROM customers;
SELECT*
FROM orders;

SELECT
c.id,
c.first_name,
o.order_id,
o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id=o.customer_id


--C) LEFT JOIN   (GET ALL customers ALONG WITH THEIR orders, INCLUDING THOES WITHOUT ORDER)

SELECT*
FROM customers;
SELECT*
FROM orders;

SELECT
c.id,
c.first_name,
o.order_id,
o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=O.customer_id


--D) RIGHT JOIN   (RETURNS ALL THE ROWS FROM RIGHT AND ONLY MATCHING FROM THE LEFT) (GET ALL THE customers ALONG WITH THEIR orders, INCLUDING orders WITHOUT MATCHING customers)

SELECT*
FROM customers;
SELECT*
FROM orders;

SELECT
c.id,
c.first_name,
o.customer_id,
o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON o.customer_id=c.id

--E) FULL JOIN 

SELECT*
FROM customers;
SELECT*
FROM orders;

SELECT
c.id,
c.first_name,
o.order_id,
o.sales
FROM customers AS c
FULL JOIN orders AS O
ON c.id=o.order_id


--2) ADVANCE JOINS 

--A) ANTI LEFT JOIN     (GET ALL customers WHO HAVEN’T PLACE ANY orders)

SELECT*
FROM customers;
SELECT*
FROM orders;

SELECT
c.id,
c.first_name,
o.customer_id,
o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON o.customer_id=c.id
WHERE o.customer_id IS NULL

SELECT*
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=o.customer_id
WHERE o.customer_id IS NULL


--B) RIGHT ANTI      (GET ALL orders WITHOUT MATCHING customers)

SELECT*
FROM customers;
SELECT*
FROM orders;

SELECT*
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id=o.customer_id
WHERE c.id IS NULL

SELECT*
FROM orders AS o
LEFT JOIN customers AS c
ON c.id=o.customer_id
WHERE c.id IS NULL 


--C) FULL ANTI JOIN  (FIND customers WITHOUT orders AND orders WITHOUT customers)  

SELECT*
FROM customers;
SELECT*
FROM orders;

SELECT*
FROM customers AS c
FULL JOIN orders AS o
ON c.id=o.customer_id 
WHERE C.id IS NULL OR o.customer_id IS NULL


-- TASK - (GET ALL customers ALONG WITH THEIR orders, BUT ONLY FOR customers WHO HAVE PLACED AN orders)


SELECT*
FROM customers;
SELECT*
FROM orders;

SELECT*
FROM customers AS c
FULL JOIN orders AS o
ON c.id=o.customer_id
WHERE c.id=o.customer_id

SELECT*
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=o.customer_id
WHERE o.customer_id IS NOT NULL

--D) CROSS JOIN  (GENERATE ALL POSSIBLE COMBINATION OF customers AND orders)

SELECT*
FROM customers;
SELECT*
FROM orders;

SELECT*
FROM customers  
CROSS JOIN orders


---------------------------          TASK WORK FOR MULTIPLE TABLE JOIN PRATICE                  -----------------------------

/*USING SalesDB, RETRIEVE A LIST OF ALL orders, ALONG WITH THE RELATED customer, product, and employee details.
FOR EACH order, display:
(Order ID, Customer’s name, Product name, Sales, Product price, Salesperson’s name) */

SELECT
o.OrderID,
o.Sales,
c.FirstName AS Customer_frist_name,
c.LastName AS Customer_last_name,
p.Product AS Product_name,
p.Price AS Product_price,
e.FirstName AS Salesperson_frist_name,
e.LastName  AS Salesperson_Last_Name
FROM Sales.Orders AS o
LEFT JOIN Sales.Employees AS e
ON o.CustomerID=e.EmployeeID
LEFT JOIN Sales.Customers AS c
ON o.CustomerID=c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.CustomerID=p.ProductID


