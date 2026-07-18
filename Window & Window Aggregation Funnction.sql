---- II) WINDOW FUNCTION
     --------------------

--  # FOR UNDERSTANDING WHAT IS WINDOW FUNCTION 


/* GROUP BY TASK */

-- TASK – (FIND TOTAL SALES ACROSS ALL ORDERS)

SELECT
SUM(o.Sales) AS Total_Sales
FROM Sales.Orders AS o;

-- TASK - (FIND THE TOTAL SALES FOR EACH PRODUCT)

SELECT
o.ProductID,
SUM(o.Sales) AS Total_Sales
FROM Sales.Orders AS o
GROUP BY o.ProductID;

-- TASK - (FIND THE TOTAL SALES FOR EACH PRODUCT,ADDITIONALLY PROVIDE DETAILS SUCH ORDER ID & ORDER DATE)

SELECT
o.OrderID,
o.OrderDate,
o.ProductID,
SUM(o.Sales) AS Total_Sales
FROM Sales.Orders AS o
GROUP BY o.ProductID,o.OrderID,o.OrderDate;


/* WINDOW FUNCTION TASK */

-- TASK - (FIND THE TOTAL SALES FOR EACH PRODUCT,ADDITIONALLY PROVIDE DETAILS SUCH ORDER ID & ORDER DATE)

SELECT
o.OrderID,
o.OrderDate,
o.ProductID,
SUM(o.Sales) OVER(PARTITION BY O.ProductID) AS Total_Sales
FROM Sales.Orders AS o;


--- #) WINDOW SYNTAX

-- . OVER CLAUSE

-- PARTITION BY           TASK – (FIND THE TOTAL SALES ACROSS ALL ORDERS, ADDITIONALLY PROVIDE DETAILS SUCH AS ORDERID AND ORDERDATE)
    
 SELECT
 o.OrderID,
 o.OrderDate,
 SUM(o.Sales) OVER () AS Total_Sales
 FROM Sales.Orders AS o;

 -- PARTITION BY         TASK – (FIND THE TOTAL SALES OF EACH PRODUCT, ADDITIONALLY PROVIDE DETAILS SUCH AS ORDERID AND ORDERDATE)

 SELECT
 o.OrderID,
 o.OrderDate,
 o.ProductID,
 SUM(o.Sales) OVER (PARTITION BY o.ProductID) AS Total_Sales
 FROM Sales.Orders AS o;

 -- PARTITION BY         TASK – (FIND THE TOTAL SALES OF EACH PRODUCT AND TOTAL SALES ACROSS ALL ORDERS, ADDITIONALLY PROVIDE DETAILS SUCH AS ORDERID AND ORDERDATE)

  SELECT
 o.OrderID,
 o.OrderDate,
 o.ProductID,
 SUM(o.Sales) OVER () AS Total_Sales,
 SUM(o.Sales) OVER (PARTITION BY o.ProductID) AS Total_Sales_ByProduct
 FROM Sales.Orders AS o;

 /* PARTITION BY        TASK – (FIND THE TOTAL SALES OF EACH PRODUCT AND TOTAL SALES ACROSS ALL ORDERS AND TOTAL SALES FOR EACH COMBINATION OF PRODUCT AND ORDER STATUS, 
 ADDITIONALLY PROVIDE DETAILS SUCH AS ORDERID AND ORDERDATE) */

 
 SELECT
 o.OrderID,
 o.OrderDate,
 o.ProductID,
 o.OrderStatus,
 SUM(o.Sales) OVER () AS Total_Sales,
 SUM(o.Sales) OVER (PARTITION BY o.ProductID) AS Total_Sales_ByProduct,
 SUM(o.Sales) OVER (PARTITION BY o.ProductID,o.OrderStatus) AS SalesBy_Product_And_OrderStatus 
 FROM Sales.Orders AS o;


-- ORDER BY CLAUSE      TASK – (RANK EACH ORDER BASED ON THEIR SALES FROM THE HIGHEST TO THE LOWEST, ADDITIONALLY PROVIDE DETAILS SUCH ORDER ID & ORDER DATE)

SELECT 
o.OrderID,
o.OrderDate,
o.Sales,
RANK() OVER (ORDER BY o.Sales DESC) AS Rank_Sales
FROM Sales.Orders AS o;

-- FRAME  CLAUSE

-- FOR UNDERSTANDING HOW FRAME WORKS

-- ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING


SELECT
o.OrderID,
o.OrderDate,
o.Sales,
SUM(o.Sales) OVER (PARTITION BY o.OrderStatus ORDER BY o.OrderDate
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS Total_Sales
FROM Sales.Orders AS o


-- NORMAL PRECEDING VS COMPACT PRECEDING

SELECT
o.OrderID,
o.OrderDate,
o.Sales,
SUM(o.Sales) OVER (PARTITION BY o.OrderStatus ORDER BY o.OrderDate
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Total_Sales
FROM Sales.Orders AS o;

SELECT
o.OrderID,
o.OrderDate,
o.Sales,
SUM(o.Sales) OVER (PARTITION BY o.OrderStatus ORDER BY o.OrderDate
ROWS 2 PRECEDING) AS Total_Sales
FROM Sales.Orders AS o;

-- DEFAULT FRAME AND NORMAL CALCULATION 

SELECT
o.OrderID,
o.OrderDate,
o.OrderStatus,
o.Sales,
SUM(o.Sales) OVER (PARTITION BY o.OrderStatus ORDER BY o.OrderDate)
FROM Sales.Orders AS o;



SELECT
o.OrderID,
o.OrderDate,
o.OrderStatus,
o.Sales,
SUM(o.Sales) OVER (PARTITION BY o.OrderStatus ORDER BY o.OrderDate 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM Sales.Orders AS o;


SELECT
o.OrderID,
o.OrderDate,
o.OrderStatus,
o.Sales,
SUM(o.Sales) OVER (PARTITION BY o.OrderStatus ORDER BY o.OrderDate
ROWS UNBOUNDED PRECEDING)
FROM Sales.Orders AS o;

-- LIMITATION OF WINDOW CLAUSE 

-- SQL EXECUTE WINDOW FUNCTIONS AFTER WHERE CLAUSE     TASK – (FIND THE TOTAL SALES OF EACH ORDER, ONLY FOR TWO PRODUCTS 101 AND 102)

SELECT 
o.OrderID,
o.ProductID,
o.OrderDate,
o.Sales,
SUM(o.Sales) OVER (PARTITION BY o.OrderStatus)
FROM Sales.Orders AS o
WHERE o.ProductID in (101,102);


-- WINDOW FUNCTION CAN BE USED TOGETHER WITH GROUP BY IN THE SAME QUERY ONLY IF THE SAME COLUMN USED      TASK – (RANK THE TOTAL CUSTOMER BASED ON THEIR TOTAL SALES)

SELECT
o.CustomerID,
SUM(o.Sales) AS Total_Sales,
RANK() OVER (ORDER BY SUM(o.Sales) DESC) AS Rank 
FROM Sales.Orders AS o
GROUP BY o.CustomerID


---- III) WONDOW AGGREGATION FUNCTION 
         ---------------------------

--- . COUNT FUNCTION      	

-- TASK – (FIND THE TOTAL NUMBER OF ORDER)           

SELECT
COUNT(*) AS TotalOrders
FROM Sales.Orders AS o;


-- TASK – (FIND THE TOTAL NUMBER OF ORDERS, ADDITIONALLY PROVIDE DETAILS SUCH ORDERID AND ORDER DATE).         

SELECT
o.OrderID,
o.OrderDate,
COUNT(*) OVER () TotalOrders
FROM Sales.Orders AS o;

-- TASK – (FIND THE TOTAL NUMBER OF ORDERS & FIND THE TOTAL NO OF ORDERS FOR EACH CUSTOMERS, ADDITIONALLY PROVIDE DETAILS SUCH ORDERID AND ORDER DATE)

SELECT
o.OrderID,
o.OrderDate,
o.CustomerID,
COUNT(*) OVER () TotalOrders,
COUNT(*) OVER (PARTITION BY o.CustomerID) AS OrdersbyCustomers
FROM Sales.Orders AS o;


-- SPECIAL CASE OF FUNCTION COUNT   TASK – (FIND THE TOTAL NUMBER OF CUSTOMERS,ADDITIONALLY PROVIDE ALL CUSTOMERS DETAILS).

SELECT
*,
COUNT(*) OVER () TotalCustomers
FROM Sales.Customers AS c;

-- SPECIAL CASE OF FUNCTION COUNT   TASK – (FIND THE TOTAL NUMBER OF SCORES FOR THE CUSTOMERS)

SELECT
*,
COUNT(1) OVER () TotalCustomers,
COUNT(c.Score) OVER () TotalScores,
COUNT(c.Country) OVER () AS TotalCountries
FROM Sales.Customers AS c;


-- USECASE OF COUNT FUNCTION   TASK – (CHECK WHETHER THE TABLE ‘Orders’ CONTAINS ANY DUPLICATE ROWS)

SELECT
o.OrderID,
COUNT(*) OVER (PARTITION BY o.OrderID) AS CheckPK
FROM Sales.Orders AS o;



SELECT
*
FROM (SELECT
oa.OrderID,
COUNT(*) OVER (PARTITION BY oa.OrderID) AS CheckPk
FROM Sales.OrdersArchive AS oa
)t 
WHERE t.CheckPk>1;


--- ..SUM FUNCTION 

-- TASK - (FIND THE TOTAL SALES ACROSS ALL ORDERS AND THE TOTAL SALES FOR EACH PRODUCT, ADDITIONALLY PROVIDE DETAILS SUCH AS ORDER ID AND ORDER DETAILS)

SELECT
o.OrderID,
o.OrderDate,
o.Sales,
o.ProductID,
SUM(o.Sales) OVER () AS TotalSales,
SUM(o.Sales) OVER (PARTITION BY o.ProductID) AS ProductTotalSales
FROM Sales.Orders AS o;


-- TASK - (FIND THE TOTAL PERCENTAGE CONTRIBUTION OF EACH PRODUCT’S SALES TO THE TOTAL SALES)

SELECT
o.OrderID,
o.ProductID,
o.Sales,
SUM(o.Sales) OVER () AS TotalSales,
FORMAT(CAST(o.Sales AS float)/SUM(o.Sales) OVER (), 'P') AS PercentageOfTotal
FROM Sales.Orders AS o;


--- ...AVERAGE FUNCTION 


-- TASK – (FIND THE AVERAGE RATE ACROSS ALL ORDERS AND AVERAGE SALES FOR EACH PRODCUT, ADDITIONALLY PROVIDE DETAILS SUCH AS ORDERID AND ORDERDATE)

SELECT
o.OrderID,
o.OrderDate,
o.Sales,
o.ProductID,
AVG(o.Sales) OVER () AS AvgSales,
AVG(o.Sales) OVER (PARTITION BY o.ProductID) AS AvgProductRate
FROM Sales.Orders AS o;


-- TASK – (FIND THE AVERAGE SCORE OF CUSTOMERS AND ADDITIONALLY PROVIDE A DETAILS SUCH CustomerID AND LastName)

SELECT 
c.CustomerID,
c.LastName,
c.Score,
AVG(c.Score) OVER () AS AvgSalesWithoutNulls,
AVG(COALESCE(c.Score,0)) OVER () AvgSalesWithNulls
FROM Sales.Customers AS c;


-- TASK – (FIND ALL ORDERS WHERE SALES ARE HIGHER THAN THE AVERAGE SALES  ACROSS ALL ORDERS.)
SELECT 
*
FROM 
(
SELECT
o.OrderID,
o.ProductID,
o.Sales,
AVG(o.Sales) OVER () AS AvgSales
FROM Sales.Orders AS o 
) AS t
WHERE t.Sales>t.AvgSales;


--- ....MIN/MAX FUNCTION 


-- TASK – (FIND THE HIGHEST AND LOWEST SALES ACROSS ALL ORDERS AND HIGHEST & LOWEST SALES FOR EACH PRODUCT, ADDITIONALLY PROVIDE DETAILS SUCH AS ORDERID AND ORDERDATE).

SELECT
o.OrderID,
o.OrderDate,
o.ProductID,
o.Sales,
MAX(o.Sales) OVER () AS MaxSales,
MIN(o.Sales) OVER () AS MinSales,
MAX(o.Sales) OVER (PARTITION BY o.ProductID) AS ProductMaxSales,
MIN(o.Sales) OVER (PARTITION BY o.ProductID) AS ProductMinSales
FROM Sales.Orders AS o;


-- TASK – (SHOW THE EMPLOYEES WITH THE HIGHEST SALARIES).
SELECT
*
FROM
(
SELECT
*,
MAX(e.Salary) OVER () AS HighestSalary
FROM Sales.Employees AS e 
) AS t
WHERE t.Salary >= t.HighestSalary;


-- TASK – (CALCULATE THE DEVIATION OF EACH SALES FROM BOTH THE MINIMUM AND MAXIMUM SALES AMOUNT).

SELECT
o.OrderID,
o.OrderDate,
o.ProductID,
o.Sales,
MAX(o.Sales) OVER () AS HighestSales,
MIN(o.Sales) OVER () AS LowestSales,
o.Sales - MIN(o.Sales) OVER() AS DeviationMin,
MAX(o.Sales) OVER () - o.Sales AS DeviationMax
FROM Sales.Orders AS o;



-- .....RUNNING AND ROLLING FUNCTION


-- MOVING AVERAGE -        TASK  - (CALCULATE MOVING AVERAGE OF SALES FOR EACH PRODUCT OVER TIME)

SELECT
o.OrderID,
o.ProductID,
o.OrderDate,
o.Sales,
AVG(o.Sales) OVER (PARTITION BY o.ProductID) AS AvgByProduct,
AVG(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.OrderDate) AS MovingAvgByProduct
FROM Sales.Orders AS o;


-- MOVING AVERAGE -      TASK – (CALCULATE THE MOVING AVERAGE OF SALES FOR EACH PRODUCT OVER TIME, INCLUDING ONLY THE NEXT ORDER)

SELECT
o.OrderID,
o.ProductID,
o.OrderDate,
o.Sales,
AVG(o.Sales) OVER (PARTITION BY o.ProductID) AS AvgByProduct,
AVG(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.OrderDate) AS MovingAvgByProduct,
AVG(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAvgProduct
FROM Sales.Orders AS o;





