---- 4)	RANKING WINDOW FUNCTION 
      ----------------------------

---- ^ INTEGER BASED RANKING


--- . ROW NUMBER

-- TASK – (RANK THE ORDERS BASED IN THEIR  SALES  FROM HIGHEST TO LOWEST)

SELECT
o.OrderID,
o.ProductID,
o.Sales,
ROW_NUMBER () OVER (ORDER BY o.Sales) AS RankingSales
FROM Sales.Orders AS o;


-- TASK – (FIND THE TOP HIGHEST SALES FOR EACH PRODUCT).


SELECT
*
FROM
(
SELECT
o.OrderID,
o.ProductID,
o.Sales,
ROW_NUMBER () OVER (PARTITION BY o.ProductID ORDER BY o.Sales DESC) AS RankByProduct
FROM Sales.Orders AS o
) AS t
WHERE t.RankByProduct = 1;


-- TASK – (FIND THE LOWEST 2 CUSTOMERS BASED ON THEIR TOTAL SALES)

SELECT
*
FROM
(
SELECT
o.CustomerID,
SUM (o.Sales)  AS ToalSales,
ROW_NUMBER () OVER (ORDER BY SUM (o.Sales)) AS SalesRank
FROM Sales.Orders AS o
GROUP BY o.CustomerID
) AS t
WHERE t.SalesRank IN (1,2);


-- GENERATE UNIQUE ID’S – TASK – (ASSIGN UNIQUE ID’S TO THE ROWS OF THE ‘ORDER ARCHIVE’ TABLE)

SELECT
ROW_NUMBER () OVER (ORDER BY oa.OrderID,oa.OrderDate) AS UniqueID,
*
FROM Sales.OrdersArchive AS oa;


-- IDENTIFY DUPLICATES – TASK – (INDETIFY THE DUPLICATE ROWS IN THE TABLE ‘ORDER ARCHIVE’ AND RETUNRN A CLEAN RESULT WITHOUT ANY DUPLICATES) 


SELECT
*
FROM
(
SELECT
ROW_NUMBER () OVER (PARTITION BY oa.OrderID ORDER BY oa.CreationTime) AS rn,
*
FROM SALES.OrdersArchive AS oa
) AS t
WHERE t.rn=1;


-- ..RANK 

-- TASK – (RANK THE ORDERS BASED IN THEIR  SALES  FROM HIGHEST TO LOWEST)

SELECT
o.OrderID,
o.ProductID,
o.Sales,
ROW_NUMBER () OVER (ORDER BY o.Sales) AS RowNumberSales,
RANK() OVER (ORDER BY o.Sales) AS RankSales
FROM Sales.Orders AS o;


-- ...DENSE RANK 

-- TASK – (RANK THE ORDERS BASED IN THEIR  SALES  FROM HIGHEST TO LOWEST)

SELECT
o.OrderID,
o.ProductID,
o.Sales,
ROW_NUMBER () OVER (ORDER BY o.Sales) AS RowNumberOfSales,
RANK () OVER (ORDER BY o.Sales) AS RankOfSales,
DENSE_RANK () OVER (ORDER BY o.Sales) AS DenseRankOfSales
FROM sALES.Orders AS o;


-- ....NTILE

-- TASK 

SELECT
NTILE(1) OVER (ORDER BY o.Sales DESC) AS OneBucket,
NTILE(2) OVER (ORDER BY o.Sales DESC) AS TwoBucket,
NTILE(3) OVER (ORDER BY o.Sales DESC) AS ThreeBucket,
NTILE(4) OVER (ORDER BY o.Sales DESC)AS FourBucket
FROM Sales.Orders AS o;


-- DATA SEFMENTATION – TASK – (SEGMENT ALL THE ORDERS INTO 3 CATEOGORIES: HIGH, MEDIUM, LOW)

SELECT
*,
CASE 
   WHEN t.Bucket=1 THEN 'Hight'
   WHEN t.Bucket=2 THEN 'Medium'
   WHEN t.Bucket=3 THEN 'Low'
END AS SalesSegmentation 
FROM
(
SELECT
o.OrderID,
o.Sales,
NTILE(3) OVER (ORDER BY o.Sales DESC) AS Bucket
FROM Sales.Orders AS o
) AS t;

-- EQUALIZING LOAD PROCESSING – TASK – (IN ORDER TO EXPORT THE DATA, DIVIDE THE ORDERS INTO TWO GROUP)

SELECT
NTILE(2) OVER (ORDER BY o.OrderID) AS Bucket,
*
FROM Sales.Orders AS o;



---- ^ PERCENTAGE BASED RANKING 


-- CUME_DIST - TASK – (FIND THE PRODCUT THAT FALL WITHIN THE HIGHEST 40% OF PRICES)

SELECT
*,
CONCAT(t.DistRank*100,'%') AS DistRank
FROM 
(
SELECT
p.Product,
p.Price,
CUME_DIST () OVER (ORDER BY p.Price DESC) AS DistRank
FROM Sales.Products AS p
) AS t
WHERE t.DistRank<=0.4;


-- PERCENT RANK - TASK – (FIND THE PRODCUT THAT FALL WITHIN THE HIGHEST 40% OF PRICES)

SELECT
*,
CONCAT(t.PercentRank*100,'%') AS PercentRank
FROM 
(
SELECT
p.Product,
p.Price,
PERCENT_RANK () OVER (ORDER BY p.Price DESC) AS PercentRank
FROM Sales.Products AS p
) AS t
WHERE t.PercentRank<=0.4;
