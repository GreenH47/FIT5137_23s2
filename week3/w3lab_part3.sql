drop table DimBranch;
drop table DimCategory;
drop table DimProduct;
drop table DimTime;
drop table FactSales;



create table DimBranch as
select * from opdb.Branch;
select * from DimBranch;

-- Create Product Category Dimension
CREATE TABLE DimCategory AS
SELECT * FROM opdb.Category;
SELECT * FROM DimCategory;

-- Create Product Dimension
CREATE TABLE DimProduct AS
SELECT p.PRODUCTNO, p.PRODUCTNAME, c.CATEGORYID
FROM opdb.Product p
JOIN opdb.Category c ON p.CATEGORYID = c.CATEGORYID;
SELECT * FROM DimProduct;

-- Create Time Dimension
CREATE TABLE DimTime AS
SELECT DISTINCT TO_CHAR(SALESDATE, 'YYYY-MM') AS Month, EXTRACT(YEAR FROM SALESDATE) AS Year
FROM opdb.Sales;

SELECT * FROM DimTime;
select salesdate from opdb.sales;
/*
To analyze total sales by time (month), you would use the Sales table and group the data by the month of the sales date column.
若要按时间（月）分析总销售额，请使用 Sales 表并按销售日期列的月份对数据进行分组。
To analyze total sales by branch, you would join the Sales and Branch tables using the BranchID as a common key and perform aggregations by branch.
若要按分支分析总销售额，请使用 BranchID 作为公用键联接“销售额”和“分支”表，并按分支执行聚合。
To analyze total sales by product category, you would join the Sales, Product, and Category tables using the ProductID and CategoryID as the common keys and perform aggregations by category.
若要按产品类别分析总销售额，请使用 ProductID 和 CategoryID 作为公用键联接“销售额”、“产品”和“类别”表，并按类别执行聚合。

*/
drop table FactSales;
-- Create Sales Fact Table
CREATE TABLE FactSales AS
SELECT s.SALESNO, t.Month, b.BRANCHID, c.CATEGORYID, s.QUANTITY, s.UNITPRICE, s.TOTALPRICE
FROM opdb.Sales s

JOIN DimBranch b ON s.BRANCHID = b.BRANCHID
JOIN DimCategory c ON s.PRODUCTNO = c.CATEGORYID;


SELECT * FROM FactSales;

select * from opdb.sales;

--Show the total sales by different months
SELECT Month, SUM(TOTALPRICE) AS TotalSales
FROM FactSales
GROUP BY Month

--Show the total sales by different branches and product categories
SELECT b.BRANCHID, c.CATEGORYDESC, SUM(f.TOTALPRICE) AS TotalSales
FROM FactSales f
JOIN DimBranch b ON f.BRANCHID = b.BRANCHID
JOIN DimCategory c ON f.CATEGORYID = c.CATEGORYID
GROUP BY b.BRANCHID, c.CATEGORYDESC
