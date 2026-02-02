/*1. (Use Ecommerce database) 
1.1. Create an index on the Email column in the Customers table to speed up login 
searches.  */
Use Ecommerce
create index Idx_Customers_Email
on Customers(Email)

select * 
from Customers



/*1.2. Create a composite index on Orders table for CustomerID and OrderDate to speed 
up customer order history queries. */


create nonclustered index idx_Orders_CusID_Date
on Orders(CustomerID,OrderDate)


/*1.3. Create an indexed view that shows product sales summary. 
ProductID, ProductName, OrderCount, TotalQuantitySold, TotalRevenue */

create or alter view View_Product
with schemabinding
as
select p.ProductName ,p.ProductID,COUNT_big(*) OrderCount
,sum(isnull(o.Quantity,0)) TotalQuantitySold,sum(isnull(o.UnitPrice*o.Quantity,0)) TotalRevenue
from dbo.Products p , dbo.OrderDetails o
where p.ProductID =o.ProductID
group by p.ProductID,p.ProductName


create unique clustered index idx_View_Product
on View_Product(ProductID)



/*1.4. Create an indexed view for customer lifetime value. 
CustomerID, Name, Email, TotalOrders, TotalSpent, AvgOrderValue */

create or alter view vw_Customer
with schemabinding
as
select c.CustomerID,c.FirstName,c.Email,COUNT_big(*) TotalOrders 
,count_big(*) TotalSpent
from dbo.Customers c,dbo.Orders o
where c.CustomerID=o.CustomerID
group by c.CustomerID,c.FirstName,c.Email

create unique clustered index idx_View_Customer
on vw_Customer(CustomerID)

select AVG(TotalOrders) avgAMount,v.*
from vw_Customer v ,Orders o
where v.CustomerID=o.CustomerID
group by v.CustomerID,v.FirstName,v.Email,v.TotalOrders,v.TotalSpent

/*1.5. Create a cursor to count orders for each customer. 
For each row print : <CustomerName> : <OrderCount> orders */
DECLARE @CustomerID INT
DECLARE @CustomerName VARCHAR(100)
declare @OrderCount int


declare cursor_order cursor for 
select c.CustomerID ,c.FirstName ,count(o.OrderID)
from Customers c,Orders o
where c.CustomerID =o.CustomerID
group by c.CustomerID ,c.FirstName


open cursor_order


fetch next from cursor_order into @CustomerID, @CustomerName ,@OrderCount

while @@FETCH_STATUS =0
begin 
    PRINT 'Customer #' + CAST(@CustomerID AS VARCHAR) + ': ' + @CustomerName +' ordercount: ' +CAST(@OrderCount AS VARCHAR) 
	 
   fetch next from cursor_order into @CustomerID, @CustomerName ,@OrderCount


end 

close cursor_order



/*1.6. Add CHECK constraints to Product 
StockQuantity >= 0 
Price >= 0.01 AND Price <= 100000 */

alter table Product 
add constraint pro_check check(StockQuantity >= 0 and Price >= 0.01 AND Price <= 100000)



/*1.7. Add UNIQUE constraint to customers email, then try to insert duplicate email*/


alter table Customers 
add constraint uniEmail unique (Email);

insert into Customers(CustomerID,Email)
values(30,'john@email.com')


select *
from Customers