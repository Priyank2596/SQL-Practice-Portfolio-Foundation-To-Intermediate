
                 /* LEARNING ABOUT ROW LEVEL FUNCTION*/


 /* THERE ARE TWO TYPES OF ROW LEVEL FUNCTION

    A)SINGLE-ROW VALUE 
    B) MULTIPLE-ROW VALUE              */

---------------------------------- SINGLE-ROW VALUE-----------------------------------------

--THERE ARE 4 TYPES OF FUNCTION IN SINGLE-ROW FUNCTION


-- 1) STRING FUNCTIONS
----------------------

-- #) MANIPULATION 

-- I) CONCATENATE   (TASK- (CONCATENATE FIRST NAME AND COUNTRY INTO ONE COLUMN))   

SELECT
c.first_name,
c.country,
CONCAT(c.first_name,'-',c.country) AS name_country
FROM customers AS c;


-- II) UPPER      (TASK – (CONVERT THE First_Name TO UPPERCASE))

SELECT
c.first_name,
c.country,
CONCAT(c.first_name,'-',c.country) AS Name_Country,
UPPER(c.first_name) AS up_name
FROM customers AS c;


-- III) LOWER     (TASK – (CONVERT THE First_Name TO UPPERCASE))

SELECT
c.first_name,
c.country,
CONCAT(c.first_name,'-',c.country) AS Name_Country,
UPPER(c.first_name) AS up_name,
LOWER(c.first_name) AS low_name
FROM customers AS c;



-- IV) TRIM      (TASK - (FIND THE CUSTOMERS WHOES first_name CONTAINS LEADING AND TRAILING SPACES))

SELECT
c.first_name
FROM customers AS c
WHERE c.first_name != TRIM(c.first_name);

/* ANOTHER WAY */

SELECT
c.first_name,
LEN(c.first_name) AS len_name,
LEN(TRIM(c.first_name)) AS len_trim_name,
LEN(c.first_name) - LEN(TRIM(c.first_name)) AS flag 
FROM customers AS c
WHERE LEN(c.first_name)!= LEN(TRIM(c.first_name));



-- V) REPLACE    ( TASK – (REMOVE DASHES (-) FORM A POHNE NUMBER))

SELECT
'123-456-789' AS phone_no,
REPLACE('123-456-789','-','') AS clean_phone_no



-- VI) REPLACE   (TASK - (REPLACE FILE EXTENCE FROM TXT TO CSV)

SELECT
'report.txt' AS old_file
REPLACE('report.txt','.txt','.csv') AS new_file



-- #) CALCULATION


-- I) LEN   (TASK – (CALCULATE THE LENGTH OF EACH CUSTOMER’S first_name))

SELECT
c.first_name,
LEN(c.first_name) AS len_name
FROM customers AS c


-- #) STIRNG EXTRACTION  


-- I) LEFT  (TASK – (RETRIEVE THE FIRST TWO CHARACTERS OF FIRST NAME))

SELECT
c.first_name,
LEFT(TRIM(c.first_name),2) AS first_2_chara
FROM customers AS c



-- II) RIGTH (TASK – (RETRIEVE THE LAST TWO CHARACTERS OF FIRST NAME))

SELECT
c.first_name,
LEFT(TRIM(c.first_name),2) AS first_2_chara,
RIGHT(c.first_name,2) AS last_2_char
FROM customers AS c;



-- III) SUBSTRING    (TASK – (RETRIEVE A LIST OF CUSTOMERS FIRST NAME REMOVING THE FIRST CHARACTER))

SELECT
c.first_name,
SUBSTRING(TRIM(c.first_name),2,LEN(c.first_name))
FROM customers AS c;


-- 2) NUMBER FUNCTION 
---------------------

-- #) ROUND 

SELECT
3.516,
ROUND(3.516,2) AS round_2,
ROUND(3.516,1) AS round_1,
ROUND(3.516,0) AS round_0;
     
-- #) ABS

SELECT
-10 AS negative_no,
ABS(-10) AS positve_no,
ABS(10) AS no_changes;


-- 3) DATE AND TIME FUNCTIONS

-- THOES ARE THE THREE DIFFERNT SOURCES OF GETTING  DATE INFORMATION INSIDE YOUR QUERY
-- DATE COLUMN FROM A TABLE

SELECT
o.OrderID,
o.OrderDate,
o.ShipDate,
o.CreationTime
FROM Sales.Orders AS o;

-- HARD CORE CONSTANT STRING VALUES 

SELECT
o.OrderID,
o.CreationTime,
'2025-07-25' AS hardcoded
FROM Sales.Orders AS o;

-- GET () DATE FUNCTION 

SELECT
o.OrderID,
o.CreationTime,
'2025-07-25' AS Hardcoded,
GETDATE() AS Today
FROM Sales.Orders AS o;


-- #) PART EXTRACTION 

-- I) DAY  
 
SELECT
o.OrderID,
o.CreationTime,
YEAR(o.creationTime) AS Year
FROM Sales.Orders AS o;

-- II) MONTH

SELECT
o.OrderID,
o.CreationTime,
YEAR(o.creationTime) AS Year,
MONTH(o.CreationTime) AS Month
FROM Sales.Orders AS o


-- III) DAY 

SELECT
o.OrderID,
o.CreationTime,
YEAR(o.creationTime) AS Year,
MONTH(o.CreationTime) AS Month,
DAY(o.CreationTime) AS Day
FROM Sales.Orders AS o;


-- IV) DATEPART() 

SELECT
o.OrderID,
o.CreationTime,
DATENAME(month,o.CreationTime) AS Month_dn,
DATENAME(weekday,o.CreationTime) AS Weekday_dn,
DATENAME(day,o.CreationTime) AS day_dn,
DATENAME(year,o.CreationTime) AS Year_dn,
DATEPART(year,o.CreationTime) AS Year_dp,
DATEPART(month,o.CreationTime) AS Month_dp,
DATEPART(day,o.CreationTime) AS Day_dp,
DATEPART(hour,o.CreationTime) AS Hour_dp,
DATEPART(quarter,o.CreationTime) AS Quarter_dp,
DATEPART(week,o.CreationTime) AS Week_dp,
YEAR(o.creationTime) AS Year,
MONTH(o.CreationTime) AS Month,
DAY(o.CreationTime) AS Day
FROM Sales.Orders AS o;


-- V) DATETRUNC  

SELECT
o.CustomerID,
o.CreationTime,
DATETRUNC(minute,o.CreationTime) AS Min_dt,
DATETRUNC(day,o.CreationTime) AS Date_dt,
DATETRUNC(year,o.CreationTime) AS Year_dt
FROM Sales.Orders AS o;

-- EXAMPLE 
SELECT
DATETRUNC(month,o.CreationTime) AS order_dates,
COUNT(*) AS count_order
FROM Sales.Orders AS o
GROUP BY DATETRUNC(month,o.CreationTime);


-- VI) EOMONTH 

SELECT
o.OrderID,
o.CreationTime,
EOMONTH(o.CreationTime) AS Eo_month
FROM Sales.Orders AS o;

SELECT
o.OrderID,
o.CreationTime,
EOMONTH(o.CreationTime) AS Eo_month,
CAST(DATETRUNC(month,o.CreationTime) AS DATE) AS Start_of_Month
FROM Sales.Orders AS o;

-------------------------- PART EXTRACTION USECASE -----------------------------------

-- IMPLEMENTATION OF PART EXTRACTION FOR AGGREGATION    (TASK - (HOW MANY ORDER PLACED EACH YEAR))

SELECT
YEAR(o.OrderDate),
COUNT(*)
FROM Sales.Orders AS o
GROUP BY YEAR(o.OrderDate);



-- IMPLEMENTATION OF PART EXTRACTION FOR AGGREGATION    (TASK - (HOW MANY ORDER PLACED EACH MONTH))

SELECT 
DATENAME(month,o.OrderDate) AS order_month,
COUNT(*) AS no_of_orders
FROM Sales.Orders AS o
GROUP BY DATENAME(month,o.OrderDate);

-- IMPLEMENTATION OF PART EXTRACTION FOR  DATA FILTERING   (TASK - (SHOW ALL THE ORDERS THAT WERE PLACED DURING THE MONTH OF FEBRUARY)

SELECT*
FROM Sales.Orders AS o
WHERE MONTH(o.OrderDate) =2;
-----------------------------------------------------------------------------------------

-- #) FORMAT AND CASTING 

--I) FORMAT 

SELECT
o.OrderID,
o.CreationTime,
FORMAT(o.CreationTime,'MM-dd-yyyy') AS US_format,
FORMAT(O.CreationTime,'dd-MM-yy') AS EU_format,
FORMAT(o.CreationTime,'dd') AS dd,
FORMAT(o.CreationTime,'ddd') AS ddd,
FORMAT(o.CreationTime,'dddd') AS dddd,
FORMAT(o.CreationTime,'MM') AS MM,
FORMAT(o.CreationTime,'MMM') AS MMM,
FORMAT(o.CreationTime,'MMMM') AS MMMM,
FORMAT(o.CreationTime,'yy') AS yy,
FORMAT(o.CreationTime,'yyyy') AS yyyy
FROM Sales.Orders AS o;
-----------------------------------------------------------------------
 -- TASK – (SHOW CREATION TIME USING THE FOLLOWING FORMAT: Day Wed Jan Q1 2025 12:34:56 PM)

 SELECT
 o.OrderID,
 o.CreationTime,
 'Day '+ FORMAT(o.CreationTime,'ddd yy ')+ 'Q'+DATENAME(quarter,o.CreationTime )+' '+ FORMAT(o.CreationTime,'yyyy hh:mm:ss tt')
 FROM Sales.Orders AS o;
-----------------------------------------------------------------------
 -- USECASE OF FORMAT

 -- IMPLEMENTATION OF FORMAT FOR AGGREGATION

 SELECT
 FORMAT(o.OrderDate,'MM yy') AS Order_date,
 COUNT(*)
 FROM Sales.Orders AS o
 GROUP BY  FORMAT(o.OrderDate,'MM yy')
 -----------------------------------------------------------------------

 -- II)CONVERT

 SELECT
 CONVERT(INT, '123') AS [String to INT Convert],
 CONVERT(DATE, '2025-08-20') AS [String to DATE Convert],
 CONVERT(DATE,CreationTime) AS [DATETIME to DATE Convert],
 CONVERT(VARCHAR,CreationTime,32) AS [USA STD. Style:32],
 CONVERT(VARCHAR,CreationTime,34) AS [EURO STD. Style:34]
 FROM Sales.Orders

 --III) CAST 

 SELECT
 CAST('123' AS INT) AS [String To Integer],
 CAST(123 AS VARCHAR) AS [INT To String],
 CAST('2025-06-20' AS DATE) AS [String To Date],
 CAST('2025-06-20' AS DATETIME) AS [String To DateTime],
 CreationTime,
 CAST(CreationTime AS DATE) AS [DATETIME To DATE]
 FROM Sales.Orders


 -- #) DATE CALCULATION


 -- I) DATEADD

 SELECT
 o.OrderID,
 o.OrderDate,
 DATEADD(day, -10 ,o.OrderDate) AS Ten_Days_Before,
 DATEADD(month, 3,o.OrderDate) AS Three_Months_Later,
 DATEADD(year, 2, o.OrderDate) AS Add_Year
 FROM Sales.Orders AS o;


-- II) DATEDIFF
 ------------------------------------------------------------------------------
 -- DATEDIFF USECASE      (TASK – (CALCULATE THE AGE OF EMPLOYEES))

 SELECT
 e.EmployeeID,
 e.BirthDate,
 DATEDIFF(year,e.BirthDate,GETDATE()) AS Age_Of_Employee
 FROM Sales.Employees AS e;


 -- DATEDIFF USECASE   (TASK-(FIND THE AVERAGE SHIPPING IN DAYS FOR EACH MONTH))

 SELECT
 FORMAT(o.OrderDate,'MMMM') AS Month,
 AVG(DATEDIFF(day,o.OrderDate,o.ShipDate)) AS AVG_Shipping
 FROM Sales.Orders AS o
 GROUP BY FORMAT(o.OrderDate,'MMMM')
 ORDER BY MIN(o.OrderDate);


 -- DATEDIFF USECASE    (TASK- (FIND THE NUMBER OF DAYS BETWEEN EACH ORDER AND PREVIOUS ORDER))

 SELECT
 o.OrderID,
 LAG(o.OrderDate) OVER (ORDER BY o.OrderDate) AS Previous_OrderDate,
 o.OrderDate AS Current_OrderDate,
 DATEDIFF(day, LAG(o.OrderDate) OVER (ORDER BY o.OrderDate), o.OrderDate) AS No_of_Days
 FROM sales.Orders AS o;
-------------------------------------------------------------------------------------------------


 -- #) VALIDATION 

 -- I) ISDATE

 SELECT
 ISDATE('123') AS Date_Check1,
 ISDATE('2001-07-25') AS Date_Check2,
 ISDATE('2025') AS Date_Check3,
 ISDATE('07') AS Date_Check4,
 ISDATE('25-07-2001') AS Date_Check5;

 --------------------------------------------
 -- ISDATE USECASE
SELECT 
--CAST(OrderDate AS DATE) AS Order_Date
ISDATE(OrderDate),
CASE WHEN ISDATE(OrderDate)=1 THEN CAST(OrderDate AS DATE)
ELSE '2001-07-25' 
END New_Order_Date
FROM
( 
SELECT '2025-08-20' AS OrderDate UNION
SELECT '2025-08-21' UNION
SELECT '2025-08-23' UNION
SELECT '2025-08'
)t
--WHERE ISDATE(OrderDate)=0
----------------------------------------------------------


-- 4) NULL FUNCTIONS
     ----------------

--USECASE OF HANDLING NULLS (ISNULL/COALESCE)

-- I) DATA AGGREGATION     (TASK – (FIND THE AVERAGE SCORES FOR OUR CUSTOMER))

--When null is ignored
SELECT
c.CustomerID,
c.Score,
AVG(c.Score) OVER ()  AS Average_Score
FROM Sales.Customers AS c;

--when null settlement
SELECT
c.CustomerID,
c.Score,
AVG(c.Score) OVER () AS Average_Score,
AVG(COALESCE(c.Score,0)) OVER() AS Real_Average_Score
FROM Sales.Customers AS c


-- II) MATHEMATICAL OPERATIONS      (TASK – (DISPLAY THE FULL NAME OF CUSTOMERS IN SINGLE FIELD BY MERGING THEIR FIRST AND LAST NAMES, AND ADD 10 BONUS POINTS TO EACH CUSTOMER’S SCORE))

SELECT
c.CustomerID,
c.FirstName,
c.LastName,
c.FirstName + ' ' + COALESCE(c.LastName, '') AS Full_Name,
c.Score,
COALESCE(c.Score, 0) + 10 AS Score_With_Bonus
FROM Sales.Customers AS c

-- III) HANDLING NULLS IN JOINS



-- IV) HANDLING NULLS IN SORTING         (TASK – (SORT THE CUSTOMERS FROM LOWEST TO HEIGHEST SCORES, WITH NULLS APPEARING LAST))

--HANDLE THE NULLS BEFORE SORTUNG DATA

--METHOD -1      Replace the nulls with very big numbers by using coalesce.
  
  SELECT
  c.CustomerID,
  c.FirstName,
  c.LastName,
  c.Score,
  COALESCE(c.Score,999999)
  FROM Sales.Customers AS c
  ORDER BY COALESCE(c.Score,999999)

  --METHOD - 2    Create a new case for null and put that case into order by

  SELECT
  c.CustomerID,
  c.FirstName,
  c.LastName,
  c.Score
  FROM Sales.Customers AS c
  ORDER BY CASE WHEN c.Score IS NULL THEN 1 ELSE 0 END ,c.Score;


  -- V) NULL IF 

  ----------------------------------------
  -- USECASE OF NULL IF 

  -- Preventing the error of dividing by zero         TASK - (FIND THE SALES PRICE OF EACH ORDER BY DIVIDING THE SALES BT THE QUANTITY).

  SELECT
  o.CustomerID,
  o.Sales,
  o.Quantity,
  o.Sales/NULLIF(o.Quantity,0) AS Price
  FROM Sales.Orders AS o;
-------------------------------------------

-- VI) IS NULL/IS NOT NULL
-----------------------------------------

-- USECASE OF IS NULL / IS NOT NULL

-- SEARCHING FOR MISSING INFORMATION           (TASK – (IDENTIFY THE CUSTOMERS WHO HAVE NULL SCORES))

SELECT*
FROM Sales.Customers
WHERE Score IS NULL;

-- SEARCHING FOR MISSING INFORMATION          (TASK – (LIST OF CUSTOMERS WHO HAVE SCORES))

SELECT*
FROM Sales.Customers
WHERE Score IS NOT NULL;

-- FINDING THE UNMATCHED ROWS BETWEEN TWO TABLES      (TASK – (LIST ALL DETAILS FOR CUSTOMERS WHO HAVE NOT PLACED ANY ORDERS))

SELECT
c.*,
o.OrderID
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID=o.CustomerID
WHERE o.CustomerID IS NULL;


-- VII) DIFFERENCE BETWEEN NULL/EMPTY/ BLANK SPACE

WITH Orders AS (
SELECT 1 ID, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' ' 
)
SELECT
*,
DATALENGTH (Category) AS Category_Len
FROM Orders

-- VIII) DATA POLICY

-- ^ ONLY USE NULL AND EMPTY STRINGS,BUT AVOID BLANK SPACES

-- TACKLE BLANK SPACES

WITH Orders AS (
SELECT 1 ID, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' ' 
)
SELECT
*,
DATALENGTH(TRIM(Category)) AS Policy1,
DATALENGTH (Category) AS Category_Len
FROM Orders;


-- Only use nulls and avoid using empty strings and blank spaces


WITH Orders AS (
SELECT 1 ID, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' ' 
)
SELECT
*,
TRIM(Category) AS Policy1,
nullif(TRIM(Category),'') AS Policy2,
len(isnull(TRIM(Category),''))
FROM Orders;

-- Use default value 'Unknown' and avoid using empty string,nulls and blank spaces

WITH Orders AS (
SELECT 1 ID, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' ' 
)
SELECT
*,
TRIM(Category) AS Policy1,
nullif(TRIM(Category),'') AS Policy2,
COALESCE(nullif(TRIM(Category),''),'Unknown') AS Policy3
FROM Orders;
 

 -- 5) CASE STATEMENT (WHEN CASE)


 -- USECASE OF CASE STATEMENT

 
 /* I) CATEGORIZING DATA     TASK – (GENERATE A REPORT SHOWING THE TOTAL SALES FOR EACH CATEGORY:
                                  -  HIGH – IF THE SALES HIGHER THAN 50
                                  -  MEDIUM – IF THE SALES BETWEEN 20 TO 50
                                  -  LOW – IF THE SALES EQUAL AND LOWER THAN 20
                                  -  SORT THE RESULT FROM HIGHEST TO LOWEST)  */
SELECT
Category,
SUM(Sales) AS TotalSales
FROM (
      SELECT
      o.OrderID,
      o.Sales,
      CASE 
          WHEN o.Sales >50 THEN 'High'
          WHEN o.Sales >20 THEN 'Medium'
          ELSE 'Low'
          END AS Category
       FROM Sales.Orders AS o
) AS t 
GROUP BY Category
ORDER BY TotalSales DESC;


-- II) MAPPING VALUES   TASK – (RETRIEVE EMPLOYEE DETAILS WITH GENDER DISPLAYED AS A FULL TEXT).

SELECT
e.EmployeeID,
e.FirstName,
e.LastName,
e.Gender,
CASE
   WHEN e.Gender='M' THEN 'Male'
   WHEN e.Gender='F' THEN 'Female'
   ELSE 'Not Avaiable'
END AS Gender_Full_Text
FROM Sales.Employees AS e;

-- II) MAPPING VALUES  TASK - (RETRIEVE CUSTOMER DETAILS WITH ABBEREVIATED COUNTRY CODE)


SELECT
c.CustomerID,
c.FirstName,
c.LastName,
c.Country,
CASE
   WHEN c.Country = 'Germany' THEN 'GE'
   WHEN c.Country = 'USA' THEN 'US'
   ELSE 'n/a'
END AS CountryAbbr
FROM Sales.Customers AS c;

-- III) QUICK FORM 

SELECT
c.CustomerID,
c.FirstName,
c.LastName,
c.Country,
CASE c.Country
   WHEN 'Germany' THEN 'GE'
   WHEN 'USA' THEN 'US'
   ELSE 'n/a'
END AS CountryAbbr
FROM Sales.Customers AS c;


-- IV) HANDLING NULLs       TASK – (FIND THE AVERAGE SCORES OF CUSTOMERS AND TREAT NULLS AS ZERO AND ADDITIONAL PROVIDE DETAILS SUCH CUSTOMERIDs AND LAST NAME)

SELECT
c.CustomerID,
c.FirstName,
c.LastName,
c.Score,
CASE 
   WHEN c.Score IS NULL THEN 0
   ELSE c.Score
END AS Avg_Score_Withhandling_Nulls,
AVG(c.Score) OVER () AS Avg_Without_Null,
AVG(
CASE 
   WHEN c.Score IS NULL THEN 0
   ELSE c.Score
END) OVER () AS Avg_Score_Withhandling_Nulls
FROM Sales.Customers AS c;


-- V) CONDITIONAL AGGREGATION     TASK – (COUNT HOW MANY TIMES EACH CUSTOMERS HAS MADE AN ORDER WITH SALES GREATER THAN 30)

SELECT
o.CustomerID,
SUM(CASE 
   WHEN o.Sales>30 THEN 1
   ELSE 0
END) AS Total_OrdersHightSales,
COUNT(*) AS Total_Orders
FROM Sales.Orders AS o
GROUP BY O.CustomerID;



 /*   B) MULTI-ROW FUNCTION */



-- I) AGGREGATION FUNCTION      

-- .COUNT        TASK – (FIND THE TOTAL NUMBER OF CUSTOMERS)

SELECT
COUNT(*) AS Total_No_Of_Customer
FROM Sales.Customers;

-- ..SUM      TASK – (FIND THE TOTAL SALES OF ALL ORDERS)

SELECT
COUNT(*) AS No_Of_Sales,
SUM(Sales) AS Total_Sales
FROM Sales.Orders;

-- ...Average    TASK – (FIND THE AVERAGE SALES OF ALL ORDERS).

SELECT
COUNT(*) AS No_Of_Saless,
SUM(Sales) AS Total_Sales,
AVG(Sales) AS Average_Sales
FROM Sales.Orders;

-- ....MAXIMUM    TASK – (FIND THE HIGHEST SCORE AMONG CUSTOMERS).

SELECT
COUNT(*) AS No_Of_Sales,
SUM(Sales) AS Total_Sales,
AVG(Sales) AS Average_Sales,
MAX(Sales) AS Max_Sales
FROM Sales.Orders;

-- .....MINIMUM    TASK – (FIND THE LOWEST SCORE AMONG CUSTOMERS).

SELECT
CustomerID,
COUNT(*) AS No_Of_Sales,
SUM(Sales) AS Total_Sales,
AVG(Sales) AS Average_Sales,
MAX(Sales) AS Max_Sales,
MIN(Sales) AS Min_Sales
FROM Sales.Orders
GROUP BY CustomerID;



 









