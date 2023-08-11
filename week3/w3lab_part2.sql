-- Prodcategory Dimension
create table ProdCategoryDim as
select * from opdb.Category;
select * from ProdCategoryDim;

-- Branch Dimension
create table BranchDim as
select * from opdb.Branch;
select * from BranchDim;

--Time Dimension
create table TimeDim
(
Quarter number(1),
Description varchar2(20)
);
insert into TimeDim values (1, 'Jan-Mar');
insert into TimeDim values (2, 'Apr-Jun');
insert into TimeDim values (3, 'Jul-Sep');
insert into TimeDim values (4, 'Oct-Dec');
select * from TimeDim;

-- TempFact Table
create table TempFact as
select S.SalesDate, B.BranchID, C.CategoryID, S.TotalPrice
from opdb.Branch B, opdb.Sales S, opdb.Product P, opdb.Category C
where B.BranchID = S.BranchID
and S.ProductNo = P.ProductNo
and P.CategoryID = C.CategoryID;
alter table TempFact
add (Quarter number(1));
update TempFact
set Quarter = 1
where to_char(SalesDate, 'MM') >= '01'
and to_char(SalesDate, 'MM') <= '03';
update TempFact
set Quarter = 2
where to_char(SalesDate, 'MM') >= '04'
and to_char(SalesDate, 'MM') <= '06';
update TempFact
set Quarter = 3
where to_char(SalesDate, 'MM') >= '07'
and to_char(SalesDate, 'MM') <= '09';
update TempFact
set Quarter = 4
where Quarter is null;
select * from TempFact;


-- SalesFact Table
create table SalesFact as
select Quarter, BranchID, CategoryID,
sum(TotalPrice) as Total_Sales
from TempFact
group by Quarter, BranchID, CategoryID;
select * from SalesFact;

--a. Show the total sales in different quarters.
select Quarter, sum(Total_Sales) as Total_Sales
from SalesFact
group by Quarter;

SELECT TD.Description AS Quarter, SUM(SF.Total_Sales) AS Total_Sales
FROM SalesFact SF
JOIN TimeDim TD ON SF.Quarter = TD.Quarter
GROUP BY TD.Description;

--b. Show the total sales for different branches and product categories
SELECT BD.BranchID, PD.CategoryID, SUM(SF.Total_Sales) AS Total_Sales
FROM SalesFact SF
JOIN BranchDim BD ON SF.BranchID = BD.BranchID
JOIN ProdCategoryDim PD ON SF.CategoryID = PD.CategoryID
GROUP BY BD.BranchID, PD.CategoryID;

--. Show the total sales of Kitchen supplies in Quarter 1
SELECT SF.Quarter, PD.CATEGORYDESC, SUM(SF.Total_Sales) AS Total_Sales
FROM SalesFact SF
JOIN ProdCategoryDim PD ON SF.CategoryID = PD.CategoryID
JOIN TimeDim TD ON SF.Quarter = TD.Quarter
WHERE PD.CATEGORYDESC = 'Kitchen supplies' AND TD.Description = 'Jan-Mar'
GROUP BY SF.Quarter, PD.CATEGORYDESC;


