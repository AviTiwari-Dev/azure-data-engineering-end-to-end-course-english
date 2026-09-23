-- Create Database
CREATE DATABASE training;

-- Delete Database
USE master;
-- DROP DATABASE IF EXISTS training;

-- Create Table
USE training;
CREATE TABLE employees
(
	employee_id int,
	employee_name varchar(100),
	date_of_joining datetime,
	salary float
);
-- There is limit of 1024 columns in a table

-- Delete Table
-- DROP TABLE employees;

-- Insert Data
INSERT INTO employees
(
	employee_id,
	employee_name,
	date_of_joining,
	salary
)
VALUES
	(1, 'John', '2026-09-22', 400000),
	(2, 'Don', '2025-09-22', 400000)
;

-- Select Data
USE AdventureWorksDW2025;
SELECT DISTINCT color FROM dimproduct;

-- Sort Data
SELECT * FROM dimproduct ORDER BY color DESC;
SELECT listprice FROM dimproduct ORDER BY color DESC, listprice ASC;
SELECT listprice, color FROM dimproduct ORDER BY 1; -- Sort by the number of column name in the statement

-- Comments
-- Single line comment
/*
Multi line comment
*/

-- Filter Data
--- Comparison
/*
=  Equal
>  Greater
>= Greater Equal
<  Less
<= Less Equal
<> Not Equal
*/

SELECT * FROM dimproduct WHERE listprice = 3399.99;
SELECT * FROM dimproduct WHERE color = 'Red' OR color = 'Black';
SELECT * FROM dimproduct WHERE color IN('Red', 'Black');
SELECT * FROM dimproduct WHERE color = 'Red' AND listprice > 1000;
SELECT * FROM dimproduct WHERE listprice >= 1000 AND listprice <= 2000;

--- Wild Cards
SELECT * FROM dimproduct WHERE englishproductname LIKE 'aw%';	-- Begins with condition
SELECT * FROM dimproduct WHERE englishproductname LIKE '%ce';	-- Ends with condition
SELECT * FROM dimproduct WHERE englishproductname LIKE '%aw%';	-- Contains condition
SELECT * FROM dimproduct WHERE englishproductname LIKE 'a_c%';

-- Aggregate Functions
SELECT SUM(salesamount) FROM factinternetsales;
SELECT SUM(salesamount) AS sales_amount_sum FROM factinternetsales;
SELECT AVG(salesamount) sales_amount_avg FROM factinternetsales;
SELECT MIN(salesamount) AS [sales amount min] FROM factinternetsales;
SELECT MAX(salesamount) AS "sales amount max" FROM factinternetsales;
SELECT COUNT(*) FROM dimproduct;
SELECT COUNT(1) FROM dimproduct;
SELECT COUNT(1000) FROM dimproduct;
-- Null does not mean space else black else a type of value
SELECT COUNT(listprice) FROM dimproduct;		-- Does not include null in the result count
SELECT COUNT(1) FROM dimproduct WHERE listprice IS NOT NULL;		--Proff that null is not included in the count from total rows

-- Replicate Table
SELECT * INTO dimproduct_bk_001 FROM dimproduct;	-- Table backup with complete data
SELECT * INTO dimproduct_bk_002 FROM dimproduct WHERE color = 'RED';	-- Table backup with specific data
SELECT * INTO dimproduct_bk_003 FROM dimproduct WHERE 1=2;	-- Table backup with just structure of table
SELECT productkey, englishproductname INTO dimproduct_bk_004 FROM dimproduct WHERE 1=2;	-- Table backup with just specific structure of table

-- Constraints
--- Primary Key
--- Not Null Constraint
--- Unique Key
--- Check Constraint
--- Default Constraint
CREATE TABLE emplouees_001(
	employee_id INT PRIMARY KEY IDENTITY(1,1),
	employee_name VARCHAR(100),
	date_of_joining DATETIME,
	salary FLOAT CHECK (salary >= 10000),
	email VARCHAR(100) UNIQUE not null,
	gender CHAR(1) CHECK(gender IN('M', 'F', 'O')),
	city VARCHAR(30) DEFAULT 'London'
);

-- Autoincrement with identity function (can start with any number and increment by any number)


-- Update Data
SELECT * INTO DimProduct_BkUP FROM DimProduct;

UPDATE DimProduct_BkUP SET COLOR = 'Red-High', standardcost = 1000 WHERE COLOR = 'NA';
UPDATE DimProduct_BkUP SET COLOR = 'Red-Low', standardcost = 1000 WHERE COLOR = 'Red' AND listprice < 1500;
UPDATE DimProduct_BkUP SET listprice = listprice * 1.1;

-- Delete Data
--- There are two ways to delete table data Drop and Truncate
--- Drop does not reset the identity sequence but truncate does
--- Truncate is faster and it does not have where clause
--- Drop deletes all and specific rows using Where clause
--- Truncate deletes only entire data

-- String Functions
SELECT englishproductname, LOWER(englishproductname) AS englishproductname FROM dimproduct;
SELECT englishproductname, LEFT(englishproductname, 3) AS englishproductname FROM dimproduct;
SELECT englishproductname, RIGHT(englishproductname, 3) AS englishproductname FROM dimproduct;
SELECT englishproductname, SUBSTRING(englishproductname, 3) AS englishproductname FROM dimproduct;
SELECT englishproductname, SUBSTRING(englishproductname, 3, 4) AS englishproductname FROM dimproduct;
SELECT englishproductname, LEN(englishproductname) AS englishproductname FROM dimproduct;
SELECT englishproductname, TRIM(englishproductname) AS englishproductname FROM dimproduct;
SELECT englishproductname, LTRIM(englishproductname) AS englishproductname FROM dimproduct;
SELECT englishproductname, RTRIM(englishproductname) AS englishproductname FROM dimproduct;
SELECT REPLACE('hello', 'e', 'x');
SELECT REPLACE('hello', 'l', 'x');
SELECT REPLACE('hello', 'e', 'xy');
SELECT REPLACE('hello', 'el', 'x');
SELECT REPLACE('hello', 'e', '');
SELECT REPLACE('hello', 'e', ' ');
SELECT englishproductname, REVERSE(englishproductname) AS englishproductname FROM dimproduct;
SELECT STUFF('hello', 4, 1, 'x');

SELECT FirstName + SPACE(1) + ISNULL(MiddleName, '') + SPACE(1) + LastName FROM DimEmployee;
SELECT CONCAT(FirstName, SPACE(1), MiddleName, SPACE(1), LastName) FROM DimEmployee;
SELECT CONCAT_WS(SPACE(1), FirstName, MiddleName, LastName) FROM DimEmployee;


-- Alter Data
SELECT EMPLOyeekey, FirstName, middlename, lastname INTO employees_bk FROM DimEmployee;
ALTER TABLE employees_bk ADD fullname VARCHAR(50);
UPDATE employees_bk SET fullname = CONCAT_WS(SPACE(1), FirstName, MiddleName, LastName);
SELECT * FROM employees_bk;

-- Extract firstname, middlename and lastname from fullname
ALTER TABLE employees_bk
ADD
    first_name VARCHAR(50) NULL,
    middle_name VARCHAR(50) NULL,
    last_name VARCHAR(50) NULL;

UPDATE employees_bk
SET
    first_name = LEFT(fullname, CHARINDEX(' ', fullname + ' ') - 1),

    last_name = REVERSE(
                    LEFT(
                        REVERSE(fullname),
                        CHARINDEX(' ', REVERSE(fullname) + ' ') - 1
                    )
                ),

    middle_name =
        CASE
            WHEN LEN(fullname) - LEN(REPLACE(fullname, ' ', '')) = 2
            THEN
                SUBSTRING(
                    fullname,
                    CHARINDEX(' ', fullname) + 1,
                    LEN(fullname)
                    - CHARINDEX(' ', fullname)
                    - CHARINDEX(' ', REVERSE(fullname))
                )
            ELSE NULL
        END;


-- Date Time
SELECT GETDATE()
SELECT SYSDATETIME()
SELECT SYSUTCDATETIME()
SELECT '2026-09-22'
SELECT DATEFROMPARTS(2026,9,22)
SELECT DATETIME2FROMPARTS(2026,9,22,19,29,2,10,7)

SELECT BirthDate, YEAR(BirthDate) FROM dimemployee;
SELECT BirthDate, MONTH(BirthDate) FROM dimemployee;
SELECT BirthDate, DAY(BirthDate) FROM dimemployee;

---Datepart returns integer
SELECT DATEPART(YYYY, GETDATE());
SELECT DATEPART(MM, GETDATE());
SELECT DATEPART(DD, GETDATE());
SELECT DATEPART(WEEKDAY, GETDATE());

-- Datename returns string
SELECT DATENAME(YYYY, GETDATE());
SELECT DATENAME(MM, GETDATE());
SELECT DATENAME(DD, GETDATE());
SELECT DATENAME(WEEKDAY, GETDATE());

SELECT FORMAT(GETDATE(), 'yy');
SELECT FORMAT(GETDATE(), 'YY'); --Incorrect format
SELECT FORMAT(GETDATE(), 'yyyy');
SELECT FORMAT(GETDATE(), 'dd');
SELECT FORMAT(GETDATE(), 'ddd');
SELECT FORMAT(GETDATE(), 'mm'); --Minutes
SELECT FORMAT(GETDATE(), 'MM'); --Month
SELECT FORMAT(GETDATE(), 'MMM'); --Month
SELECT FORMAT(GETDATE(), 'MMMM'); --Month
SELECT FORMAT(GETDATE(), 'hh'); --hour
SELECT FORMAT(SYSUTCDATETIME(), 'yyyy-MM-dd hh:mm:ss');
SELECT GETUTCDATE() AT TIME ZONE 'India Standard Time' AS india_time;

SELECT DATEADD(YEAR, 1, GETDATE())
SELECT DATEADD(MM,1,GETDATE())
SELECT DATEADD(YEAR,-3, GETDATE())
SELECT DATEDIFF(YEAR,DATEFROMPARTS(2010,1,1),GETDATE())
SELECT EOMONTH(GETDATE(),0)
SELECT EOMONTH(GETDATE(),1)
SELECT EOMONTH(GETDATE(),-1)

-- Data types
/* Exact numeric data types
bigint  8 bytes
int     4 bytes
smallint 2 bytes
tinyint 1 byte ( 0 to 255)
*/

/* Approximte numeric data types
float
real
money
smalmoney
decimal
numeric
*/

/* Date data types
date
datetime
datetime2
smalldatetime
time
*/

/*
Unique Indentifier (GUID)
*/

CREATE TABLE tblEmployees(
    Employeeid uniqueidentifier default NEWID(),
    Empname varchar(100)
);
insert into tblEmployees(Employeeid,Empname) values (newid(),'john');
insert into tblEmployees(Empname) values  ('john');
SELECT * FROM tblEmployees;
-- DROP TABLE tblEmployees;

/*
Bit
*/
CREATE TABLE tblemps(
    empid int,
    empname VARCHAR(100),
    isactive bit
);
insert into tblemps(empid, empname, isactive)values(1,'yusuf', 1);
insert into tblemps(empid, empname, isactive)values(2, 'sam', 0);
insert into tblemps(empid, empname, isactive)values(3,'yusuf', 'True');
insert into tblemps(empid, empname, isactive)values(4, 'sam', 'False');
select * from tblemps;

-- Data type conversion
SELECT 10 + 20;
SELECT '10' + '20';
--- implicit conversion
SELECT '10' + 20;
SELECT 10 + '20';
--- Explicit conversion
SELECT CAST('20' AS INT);
SELECT CAST(LISTPRICE AS MONEY) FROM dimproduct;
SELECT CONVERT(INT, '20');
SELECT CONVERT(MONEY, listprice) FROM dimproduct;

--Joins
--- Inner join, left join and right join
--- left anti join, right anti join
--- left join and left outer join are same similar for right and right outer join
--- Full outer join is combination of left inner and right parts

SELECT c.firstname, p.englishproductname, f.salesamount
FROM dimproduct AS p JOIN factinternetsales AS f ON p.productkey = f.productkey
JOIN dimcustomer AS c ON c.customerkey = f.customerkey;

SELECT 'P-' + format(ProductKey, '0000') AS productid, Englishproductname into dimproducts from dimproduct;
SELECT * FROM dimproducts;
SELECT p.productid, p.englishproductname, f.salesamount FROM dimproducts p JOIN factinternetsales f ON Right(p.productid,4) = f.productkey;
