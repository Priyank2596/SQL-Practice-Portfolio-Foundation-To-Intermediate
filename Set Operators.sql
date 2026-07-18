-------------------- LEARNING ABOUT SET OPERATORS IN JOINS ------------------------

/* THERE ARE DIFFERENT TYPE OF SET OPERATORS */


--1) UNION    (COMBINE THE DATA FROM Sales.Employees AND Sales.Customers INTO ONE TABLE)

SELECT*
FROM Sales.Customers;
select*
FROM Sales.Employees;


SELECT
c.FirstName,
c.LastName
FROM Sales.Customers AS c
UNION 
SELECT
e.FirstName,
e.LastName
FROM Sales.Employees AS e


--2) UNION ALL    (COMBINE THE DATA FROM Sales.Employees AND Sales.Customers INTO ONE TABLE, INCLUDING DUPLICATES)


SELECT*
FROM Sales.Customers;
select*
FROM Sales.Employees;


SELECT
c.FirstName,
c.LastName
FROM Sales.Customers AS c
UNION ALL
SELECT
e.FirstName,
e.LastName
FROM Sales.Employees AS e


--3) MINUS/EXCEPT -      (FIND THE Sales.Employees WHO ARE NOT THE Sales.Customers AT THE SAME TIME)

SELECT*
FROM Sales.Customers;
select*
FROM Sales.Employees;

SELECT
e.FirstName,
e.LastName
FROM Sales.Employees AS e
EXCEPT
SELECT
c.FirstName,
c.LastName
FROM Sales.Customers AS c

--4) INTERSECT   (FIND THE Sales.Employees WHO ARE ALSO Sales.Customers)

SELECT*
FROM Sales.Customers;
select*
FROM Sales.Employees;


SELECT
e.FirstName,
e.LastName
FROM Sales.Employees AS e
INTERSECT
SELECT
c.FirstName,
c.LastName
FROM Sales.Customers AS c;



--5) SQL TASKS[SET OPERATORS]   (ORDER ARE STORED IN SEPARATE TABLES (ORDERS AND ORDERSARCHIVE). COMBINE ALL THE ORDERS INTO ONE REPORT WITHOUT DUPLICATES)

SELECT*
FROM Sales.Orders;
SELECT*
FROM Sales.OrdersArchive;


SELECT
'Orders' AS SourceTable,
       [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION
SELECT
'OrdersArchive' AS SourceTable,
[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive 
ORDER BY OrderID