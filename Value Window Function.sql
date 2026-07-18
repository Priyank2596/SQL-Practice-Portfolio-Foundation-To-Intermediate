----- 5) VALUE WINDOW FUNCTION 
         ----------------------

--- .LEAD AND LAG FUNCTION

-- TASK – (ANALZYE THE MONTH-OVER-MONTH(MOM) PERFORMANCE BY FINDING THE PERCENTAGE CHANGES IN SALES BETWEEN CURRENT AND PREVIOUS MONTH).

SELECT
*,
t.CurrentMonthSales-t.PreviousMonthSales AS MoMChange,
ROUND(CAST((t.CurrentMonthSales-t.PreviousMonthSales)AS float)/t.PreviousMonthSales*100,1) AS PercentageChange
FROM
(
SELECT
MONTH(o.OrderDate) AS OrderMonth,
SUM(o.Sales) AS CurrentMonthSales,
LAG(SUM(o.Sales)) OVER (ORDER BY MONTH(o.OrderDate)) PreviousMonthSales
FROM Sales.Orders AS o
GROUP BY MONTH(o.OrderDate)
) AS t;


-- CUSTOMER RENTATION ANALYSIS -TASK – (ANALYZE CUSTOMER LOYALITY BY RANKING CUSTOMER BASED ON AVERAGE NUMBER OF DAYS BETWEEN ORDERS).

SELECT
CustomerID,
AVG(t.DaysUntilNextOrder) AS AvgDays,
RANK () OVER (ORDER BY COALESCE(AVG(t.DaysUntilNextOrder),9999)) AS RankAvg
FROM
(
SELECT
o.OrderID,
o.CustomerID,
o.OrderDate AS CurrentOrder,
LEAD(o.OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
DATEDIFF(Day,o.OrderDate,LEAD(o.OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)) AS DaysUntilNextOrder
FROM Sales.Orders AS o
)AS t
GROUP BY CustomerID;

-- FIRST VALUE AND LAST VALUE - TASK – (FIND THE LOWEST AND THE HIGHEST SALES FOR EACH PRODUCT)

SELECT
o.OrderID,
o.ProductID,
o.Sales,
FIRST_VALUE (o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales) AS LowestSales,
LAST_VALUE(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS HighestSales,
FIRST_VALUE (o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales DESC) AS HighestSales,
MIN(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales) AS LowestSales,
MAX(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales) AS LowestSales
FROM Sales.Orders AS o;


-- FIRST VALUE AND LAST VALUE - TASK – (FIND THE LOWEST AND THE HIGHEST SALES FOR EACH PRODUCT, FIND THE DIFFERNCE IN SALES BETWEEN THE CURRENT AND LOWEST SALES)

SELECT
o.OrderID,
o.ProductID,
o.Sales,
FIRST_VALUE (o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales) AS LowestSales,
LAST_VALUE(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS HighestSales,
o.Sales-FIRST_VALUE(o.Sales) OVER (PARTITION BY o.ProductID ORDER BY o.Sales) AS SalesDifference
FROM Sales.Orders AS o;

